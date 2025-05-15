//
//  CartCalculationUtility.swift
//  eaturi
//
//  Created by Raphael Gregorius on 28/03/25.
//

import Foundation

enum CartCalculationUtility {
    static func calculateTotalCalories(cartItems: [UUID: Int], foodItems: [FoodModel]) -> Int {
        cartItems.reduce(0) { total, entry in
            if let foodItem = foodItems.first(where: { $0.id == entry.key }) {
                return total + (foodItem.calories * entry.value)
            }
            return total
        }
    }
    
    static func calculateTotalPrice(cartItems: [UUID: Int], foodItems: [FoodModel]) -> Int {
        cartItems.reduce(0) { total, entry in
            if let foodItem = foodItems.first(where: { $0.id == entry.key }) {
                return total + (foodItem.price * entry.value)
            }
            return total
        }
    }
    
    static func calculateTotalCarbs(cartItems: [UUID: Int], foodItems: [FoodModel]) -> Int {
        cartItems.reduce(0) { total, entry in
            if let foodItem = foodItems.first(where: { $0.id == entry.key }) {
                return total + (foodItem.carbs * entry.value)
            }
            return total
        }
    }
    
    static func calculateTotalFiber(cartItems: [UUID: Int], foodItems: [FoodModel]) -> Int {
        cartItems.reduce(0) { total, entry in
            if let foodItem = foodItems.first(where: { $0.id == entry.key }) {
                return total + (foodItem.fiber * entry.value)
            }
            return total
        }
    }
    
    static func calculateTotalFat(cartItems: [UUID: Int], foodItems: [FoodModel]) -> Int {
        cartItems.reduce(0) { total, entry in
            if let foodItem = foodItems.first(where: { $0.id == entry.key }) {
                return total + (foodItem.fat * entry.value)
            }
            return total
        }
    }
    
    static func calculateTotalQuantity(cartItems: [UUID: Int]) -> Int {
        cartItems.values.reduce(0, +)
    }
    
    static func calculateTotalProtein(cartItems: [UUID: Int], foodItems: [FoodModel]) -> Int {
        cartItems.reduce(0) { total, entry in
            if let foodItem = foodItems.first(where: { $0.id == entry.key }) {
                return total + (foodItem.protein * entry.value)
            }
            return total
        }
    }
}
