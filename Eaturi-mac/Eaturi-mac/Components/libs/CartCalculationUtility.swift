//
//  CartCalculationUtility.swift
//  eaturi
//
//  Created by Raphael Gregorius on 28/03/25.
//

import Foundation
import SwiftData

enum CartCalculationUtility {
    /// Calculate total calories for all items in cart
    static func calculateTotalCalories(cartItems: [CartItem], foodItems: [FoodModel]) -> Int {
        cartItems.reduce(0) { total, cartItem in
            if let foodItem = foodItems.first(where: { $0.id == cartItem.foodId }) {
                return total + (foodItem.calories * cartItem.quantity)
            }
            return total
        }
    }
    
    /// Calculate total price for all items in cart
    static func calculateTotalPrice(cartItems: [CartItem], foodItems: [FoodModel]) -> Double {
        cartItems.reduce(0.0) { total, cartItem in
            if let foodItem = foodItems.first(where: { $0.id == cartItem.foodId }) {
                return total + (foodItem.price * Double(cartItem.quantity))
            }
            return total
        }
    }
    
    /// Calculate total carbohydrates for all items in cart
    static func calculateTotalCarbs(cartItems: [CartItem], foodItems: [FoodModel]) -> Int {
        cartItems.reduce(0) { total, cartItem in
            if let foodItem = foodItems.first(where: { $0.id == cartItem.foodId }) {
                return total + (foodItem.carbs * cartItem.quantity)
            }
            return total
        }
    }
    
    /// Calculate total fat for all items in cart
    static func calculateTotalFat(cartItems: [CartItem], foodItems: [FoodModel]) -> Int {
        cartItems.reduce(0) { total, cartItem in
            if let foodItem = foodItems.first(where: { $0.id == cartItem.foodId }) {
                return total + (foodItem.fat * cartItem.quantity)
            }
            return total
        }
    }
    
    /// Calculate total quantity of all items in cart
    static func calculateTotalQuantity(cartItems: [CartItem]) -> Int {
        cartItems.reduce(0) { total, cartItem in
            total + cartItem.quantity
        }
    }
    
    /// Calculate total protein for all items in cart
    static func calculateTotalProtein(cartItems: [CartItem], foodItems: [FoodModel]) -> Int {
        cartItems.reduce(0) { total, cartItem in
            if let foodItem = foodItems.first(where: { $0.id == cartItem.foodId }) {
                return total + (foodItem.protein * cartItem.quantity)
            }
            return total
        }
    }
    
    /// Legacy support for old cart format using dictionary
    static func calculateTotalCalories(cartItems: [PersistentIdentifier: Int], foodItems: [FoodModel]) -> Int {
        cartItems.reduce(0) { total, entry in
            if let foodItem = foodItems.first(where: { $0.id == entry.key }) {
                return total + (foodItem.calories * entry.value)
            }
            return total
        }
    }
    
    /// Legacy support for old cart format using dictionary
    static func calculateTotalPrice(cartItems: [PersistentIdentifier: Int], foodItems: [FoodModel]) -> Double {
        cartItems.reduce(0.0) { total, entry in
            if let foodItem = foodItems.first(where: { $0.id == entry.key }) {
                return total + (foodItem.price * Double(entry.value))
            }
            return total
        }
    }
    
    /// Legacy support for old cart format using dictionary
    static func calculateTotalCarbs(cartItems: [PersistentIdentifier: Int], foodItems: [FoodModel]) -> Int {
        cartItems.reduce(0) { total, entry in
            if let foodItem = foodItems.first(where: { $0.id == entry.key }) {
                return total + (foodItem.carbs * entry.value)
            }
            return total
        }
    }
    
    /// Legacy support for old cart format using dictionary
    static func calculateTotalFat(cartItems: [PersistentIdentifier: Int], foodItems: [FoodModel]) -> Int {
        cartItems.reduce(0) { total, entry in
            if let foodItem = foodItems.first(where: { $0.id == entry.key }) {
                return total + (foodItem.fat * entry.value)
            }
            return total
        }
    }
    
    /// Legacy support for old cart format using dictionary
    static func calculateTotalQuantity(cartItems: [PersistentIdentifier: Int]) -> Int {
        cartItems.values.reduce(0, +)
    }
    
    /// Legacy support for old cart format using dictionary
    static func calculateTotalProtein(cartItems: [PersistentIdentifier: Int], foodItems: [FoodModel]) -> Int {
        cartItems.reduce(0) { total, entry in
            if let foodItem = foodItems.first(where: { $0.id == entry.key }) {
                return total + (foodItem.protein * entry.value)
            }
            return total
        }
    }
}
