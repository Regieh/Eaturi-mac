//
//  CartViewModel.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 14/05/25.
//
import Foundation
import SwiftData
import Combine

class CartViewModel: ObservableObject {
    @Published var cart: CartModel
    @Published var foods: [FoodModel] = []
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        
        // First fetch existing cart or create new one
        let fetchDescriptor = FetchDescriptor<CartModel>()
        do {
            let existingCarts = try modelContext.fetch(fetchDescriptor)
            if let existingCart = existingCarts.first {
                self.cart = existingCart
                print("Found existing cart with \(existingCart.items.count) items")
            } else {
                // Create a new cart if none exists
                self.cart = CartModel()
                modelContext.insert(self.cart)
                print("Created new cart")
            }
        } catch {
            print("Error fetching cart: \(error)")
            self.cart = CartModel()
            modelContext.insert(self.cart)
        }
        
        loadFoods()
    }
    
    func loadFoods() {
        let fetchDescriptor = FetchDescriptor<FoodModel>()
        do {
            foods = try modelContext.fetch(fetchDescriptor)
            print("Loaded foods: \(foods.map { ($0.id, $0.name, $0.image ?? "nil") })")
            
            // Verify cart items against loaded foods
            verifyCartItems()
            
            objectWillChange.send()
        } catch {
            print("Error fetching foods: \(error)")
        }
    }
    
    // New function to verify cart items against available foods
    private func verifyCartItems() {
        // Create a set of available food IDs for quick lookup
        let availableFoodIds = Set(foods.map { $0.id })
        
        // Filter out cart items that reference non-existent foods
        let validItems = cart.items.filter { availableFoodIds.contains($0.foodId) }
        
        // If some items were invalid, update the cart
        if validItems.count != cart.items.count {
            print("Removed \(cart.items.count - validItems.count) invalid cart items")
            cart.items = validItems
            saveCart()
        }
    }
    
    func addToCart(food: FoodModel, quantity: Int = 1) {
        // Find the food in our loaded foods array by name to ensure we're using correct IDs
        if let matchingFood = foods.first(where: { $0.name == food.name }) {
            print("Adding to cart: \(matchingFood.name) with ID \(matchingFood.id)")
            cart.addItem(foodId: matchingFood.id, quantity: quantity, modelContext: modelContext)
        } else {
            // As a fallback, use the provided food ID directly
            print("Food not found in loaded foods, using provided ID: \(food.id) for \(food.name)")
            cart.addItem(foodId: food.id, quantity: quantity, modelContext: modelContext)
        }
        
        saveCart()
        objectWillChange.send()
    }
    
    func removeFromCart(food: FoodModel, quantity: Int = 1) {
        if let matchingFood = foods.first(where: { $0.name == food.name }) {
            print("Removing from cart: \(matchingFood.name) with ID \(matchingFood.id)")
            cart.removeItem(foodId: matchingFood.id, quantity: quantity)
        } else {
            print("Food not found in loaded foods, using provided ID: \(food.id) for \(food.name)")
            cart.removeItem(foodId: food.id, quantity: quantity)
        }
        
        saveCart()
        objectWillChange.send()
    }
    
    func clearCart() {
        cart.clearCart()
        saveCart()
        objectWillChange.send()
    }
    
    func saveCart() {
        do {
            try modelContext.save()
            print("Cart saved successfully with \(cart.items.count) items")
        } catch {
            print("Error saving cart: \(error)")
        }
    }
    
    func getFoodForCartItem(_ cartItem: CartItem) -> FoodModel? {
        // Look up by ID first
        if let food = foods.first(where: { $0.id == cartItem.foodId }) {
            return food
        }
        
        print("Food not found for cart item with foodId: \(cartItem.foodId)")
        return nil
    }
    
    func totalPrice() -> Double {
        let total = cart.items.reduce(0.0) { total, item in
            guard let food = getFoodForCartItem(item) else { return total }
            return total + (food.price * Double(item.quantity))
        }
        return total
    }
}
