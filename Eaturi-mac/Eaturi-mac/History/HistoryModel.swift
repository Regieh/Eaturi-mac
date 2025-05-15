//
//  HistoryModel.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 14/05/25.
//

import SwiftData
import Foundation

@Model
class HistoryRecord {
    @Attribute(.unique) var id: UUID
    var timestamp: Date
    var cartData: Data
    var totalPrice: Int
    var totalCalories: Int
    var totalProtein: Int
    var totalCarbs: Int
    var totalFiber: Int
    var totalFat: Int
    var totalQuantity: Int
    
    var cart: [UUID: Int] {
        get {
            do {
                return try JSONDecoder().decode([UUID: Int].self, from: cartData)
            } catch {
                print("Error decoding cart: \(error)")
                return [:]
            }
        }
        set {
            do {
                cartData = try JSONEncoder().encode(newValue)
            } catch {
                print("Error encoding cart: \(error)")
                cartData = Data()
            }
        }
    }
    
    init(
        cart: [UUID: Int],
        totalPrice: Int,
        totalCalories: Int,
        totalProtein: Int,
        totalCarbs: Int,
        totalFiber: Int,
        totalFat: Int,
        totalQuantity: Int
    ) {
        self.id = UUID()
        self.timestamp = Date()
        self.cartData = try! JSONEncoder().encode(cart)
        self.totalPrice = totalPrice
        self.totalCalories = totalCalories
        self.totalProtein = totalProtein
        self.totalCarbs = totalCarbs
        self.totalFiber = totalFiber
        self.totalFat = totalFat
        self.totalQuantity = totalQuantity
    }
}
