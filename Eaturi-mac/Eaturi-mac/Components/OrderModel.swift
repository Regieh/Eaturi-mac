//
//  OrderModel.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 16/05/25.
//

import Foundation
import SwiftData

@Model
class OrderModel {
    var id: UUID
    var date: Date
    var totalPrice: Double
    var totalCalories: Int
    var items: [CartItem] = [] // Removed @Relationship for now
    
    init(id: UUID = UUID(), date: Date = Date(), items: [CartItem] = [], totalPrice: Double = 0.0, totalCalories: Int = 0) {
        self.id = id
        self.date = date
        self.items = items
        self.totalPrice = totalPrice
        self.totalCalories = totalCalories
        for item in items {
            item.order = self
            item.cart = nil // Type is clear as CartModel?
        }
    }
}
