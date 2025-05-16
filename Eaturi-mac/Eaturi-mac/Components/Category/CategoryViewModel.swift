//
//  CategoryViewModel.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 13/05/25.
//

// CategoryViewModel.swift
import Foundation
import SwiftUI

class CategoryViewModel: ObservableObject {
    @Published var categories: [CategoryModel] = []
    
    init() {
        loadCategories()
    }
    
    private func loadCategories() {
        categories = [
            CategoryModel(name: "Ayam", image: "ayam", localName: "Ayam"),
            CategoryModel(name: "Nasi", image: "nasi", localName: "Nasi"),
            CategoryModel(name: "Ikan", image: "ikan", localName: "Ikan"),
            CategoryModel(name: "Daging", image: "sapi", localName: "Daging"),
            CategoryModel(name: "Telur", image: "telur", localName: "Telur"),
            CategoryModel(name: "Gorengan", image: "gorengan", localName: "Gorengan"),
            CategoryModel(name: "Sayuran", image: "sayur", localName: "Sayuran"),
            CategoryModel(name: "Sambal", image: "cabe", localName: "Sambal"),
            CategoryModel(name: "Lainnya", image: "lainnya", localName: "Lainnya")
        ]
    }
}
