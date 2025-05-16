//
//  FoodModel.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 13/05/25.
//
import Foundation
import SwiftData

@Model
final class FoodModel: Identifiable {
    var id: UUID
    var name: String
    var foodDescription: String
    var price: Double
    var calories: Int
    var protein: Int
    var carbs: Int
    var fat: Int
    var image: String?
    var category: String
    var popular: Bool
    var isVegan: Bool
    var isHealthy: Bool
    var isLowCalorie: Bool
    var availableDays: [String] = []
    
    init(
        id: UUID = UUID(),
        name: String,
        foodDescription: String,
        price: Double,
        calories: Int,
        protein: Int,
        carbs: Int,
        fat: Int,
        image: String?,
        category: String,
        popular: Bool,
        isVegan: Bool,
        isHealthy: Bool,
        isLowCalorie: Bool,
        availableDays: [String]
    ) {
        self.id = id
        self.name = name
        self.foodDescription = foodDescription
        self.price = price
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fat = fat
        self.image = image
        self.category = category
        self.popular = popular
        self.isVegan = isVegan
        self.isHealthy = isHealthy
        self.isLowCalorie = isLowCalorie
        self.availableDays = availableDays
    }
}
