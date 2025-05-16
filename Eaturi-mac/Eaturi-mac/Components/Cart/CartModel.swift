//
//  CartModel.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 14/05/25.
//
import Foundation
import SwiftData

@Model
class CartModel {
    var items: [CartItem] = [] // Removed @Relationship for now
    
    init() {
        self.items = []
    }
    
    func addItem(foodId: UUID, quantity: Int = 1, modelContext: ModelContext) {
        let fetchDescriptor = FetchDescriptor<FoodModel>(predicate: #Predicate { $0.id == foodId })
        if let food = try? modelContext.fetch(fetchDescriptor).first {
            if let index = items.firstIndex(where: { $0.foodId == foodId }) {
                items[index].quantity += quantity
            } else {
                let newItem = CartItem(foodId: foodId, quantity: quantity, food: food)
                items.append(newItem)
                newItem.cart = self
            }
        } else {
            print("Warning: Food with ID \(foodId) not found in context")
        }
    }
    
    func removeItem(foodId: UUID, quantity: Int = 1) {
        if let index = items.firstIndex(where: { $0.foodId == foodId }) {
            if items[index].quantity <= quantity {
                items.remove(at: index)
            } else {
                items[index].quantity -= quantity
            }
        }
    }
    
    func clearCart() {
        items.removeAll()
    }
    
    func totalItems() -> Int {
        return items.reduce(0) { $0 + $1.quantity }
    }
}

@Model
class CartItem {
    var foodId: UUID
    var quantity: Int
    var food: FoodModel? // Removed @Relationship for now
    var cart: CartModel? // Manual property
    var order: OrderModel? // Manual property
    
    init(foodId: UUID, quantity: Int, food: FoodModel? = nil) {
        self.foodId = foodId
        self.quantity = quantity
        self.food = food
    }
    
    // Computed property to get price from associated FoodModel
    var price: Double {
        food?.price ?? 0.0
    }
}
