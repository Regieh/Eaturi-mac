//
//  CartModel.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 14/05/25.
//
import Foundation

struct CartModel {
    var id = UUID()
    var cartItems: [UUID: Int]
    
    mutating func addItem(_ itemId: UUID, quantity: Int = 1) {
        cartItems[itemId, default: 0] += quantity
    }
    
    mutating func removeItem(_ itemId: UUID, quantity: Int = 1) {
        guard var currentQuantity = cartItems[itemId] else { return }
        
        currentQuantity -= quantity
        if currentQuantity <= 0 {
            cartItems.removeValue(forKey: itemId)
        } else {
            cartItems[itemId] = currentQuantity
        }
    }
    
    mutating func clearCart() {
        cartItems.removeAll()
    }
}


struct CartItem: Codable, Identifiable {
    var id: UUID
    var quantity: Int
}

