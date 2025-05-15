//
//  FoodModel.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 13/05/25.
//

import SwiftUI
import SwiftData

@Model
final class FoodModel: Identifiable, Codable {
    var id: UUID
    var name: String
    var image: String
    var price: Int
    var calories: Int
    var protein: Int
    var carbs: Int
    var fiber: Int
    var fat: Int
    var isPopular: Bool
    var categories: [String]
    var availableDays: [String]
    var foodDescription: String

    init(id: UUID = UUID(), name: String, image: String, price: Int, calories: Int, protein: Int, carbs: Int, fiber: Int, fat: Int, isPopular: Bool, categories: [String], availableDays: [String], foodDescription: String) {
        self.id = id
        self.name = name
        self.image = image
        self.price = price
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fiber = fiber
        self.fat = fat
        self.isPopular = isPopular
        self.categories = categories
        self.availableDays = availableDays
        self.foodDescription = foodDescription
    }

    enum CodingKeys: String, CodingKey {
        case name, image, price, calories, protein, carbs, fiber, fat, isPopular, categories, availableDays, foodDescription
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID()
        name = try container.decode(String.self, forKey: .name)
        image = try container.decode(String.self, forKey: .image)
        price = try container.decode(Int.self, forKey: .price)
        calories = try container.decode(Int.self, forKey: .calories)
        protein = try container.decode(Int.self, forKey: .protein)
        carbs = try container.decode(Int.self, forKey: .carbs)
        fiber = try container.decode(Int.self, forKey: .fiber)
        fat = try container.decode(Int.self, forKey: .fat)
        isPopular = try container.decode(Bool.self, forKey: .isPopular)
        categories = try container.decode([String].self, forKey: .categories)
        availableDays = try container.decode([String].self, forKey: .availableDays)
        foodDescription = try container.decode(String.self, forKey: .foodDescription)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(image, forKey: .image)
        try container.encode(price, forKey: .price)
        try container.encode(calories, forKey: .calories)
        try container.encode(protein, forKey: .protein)
        try container.encode(carbs, forKey: .carbs)
        try container.encode(fiber, forKey: .fiber)
        try container.encode(fat, forKey: .fat)
        try container.encode(isPopular, forKey: .isPopular)
        try container.encode(categories, forKey: .categories)
        try container.encode(availableDays, forKey: .availableDays)
        try container.encode(foodDescription, forKey: .foodDescription)
    }
}

extension FoodModel: Equatable {
    public static func == (lhs: FoodModel, rhs: FoodModel) -> Bool {
        return lhs.id == rhs.id
    }
}
