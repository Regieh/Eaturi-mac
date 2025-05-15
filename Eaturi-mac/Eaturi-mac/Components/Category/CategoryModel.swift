//
//  CategoryView.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 13/05/25.
//
import SwiftUI

struct CategoryModel: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var image: String
    var localName: String
    
    static func generateCategories() -> [CategoryModel] {
        return [
            CategoryModel(name: "Chicken", image: "ayam", localName: "Ayam"),
            CategoryModel(name: "Rice", image: "nasi", localName: "Nasi"),
            CategoryModel(name: "Fish", image: "ikan", localName: "Ikan"),
            CategoryModel(name: "Beef", image: "sapi", localName: "Daging"),
            CategoryModel(name: "Egg", image: "telur", localName: "Telur"),
            CategoryModel(name: "Fried", image: "gorengan", localName: "Gorengan"),
            CategoryModel(name: "Veggies", image: "sayur", localName: "Sayuran"),
            CategoryModel(name: "Sambal", image: "cabe", localName: "Sambal"),
            CategoryModel(name: "Others", image: "lainnya", localName: "Lainnya")
        ]
    }
}
