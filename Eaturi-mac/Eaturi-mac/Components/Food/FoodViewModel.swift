//
//  FoodViewModel.swift
//  Eaturi-mac
//
//  Created on 15/05/25.
//
import Foundation
import SwiftUI
import SwiftData
import Combine

class FoodViewModel: ObservableObject {
    @Published var allItems: [FoodModel] = []
    @Published var filteredItems: [FoodModel] = []
    @Published var popularItems: [FoodModel] = []
    @Published var categories: [String] = []
    @Published var selectedCategory: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadData()
        
        // Update filtered items whenever selected category changes
        $selectedCategory
            .sink { [weak self] category in
                guard let self = self else { return }
                self.filterItemsByCategory(category)
            }
            .store(in: &cancellables)
    }
    
    func loadData() {
        // In a real app, you would load this from SwiftData
        // This is a mock implementation
        let mockItems = generateMockData()
        self.allItems = mockItems
        self.filteredItems = mockItems
        
        // Extract unique categories
        let allCategories = mockItems.flatMap { $0.categories }
        self.categories = Array(Set(allCategories)).sorted()
        
        // Filter popular items
        self.popularItems = mockItems.filter { $0.isPopular }
    }
    
    func searchItems(query: String) {
        if query.isEmpty {
            filterItemsByCategory(selectedCategory)
            return
        }
        
        let searchResults = allItems.filter { item in
            let matchesCategory = selectedCategory == nil || item.categories.contains(selectedCategory!)
            let matchesQuery = item.name.lowercased().contains(query.lowercased()) ||
                               item.categories.joined(separator: " ").lowercased().contains(query.lowercased())
            
            return matchesCategory && matchesQuery
        }
        
        self.filteredItems = searchResults
    }
    
    func filterItemsByCategory(_ category: String?) {
        if let category = category {
            self.filteredItems = allItems.filter { $0.categories.contains(category) }
        } else {
            self.filteredItems = allItems
        }
    }
    
    func selectCategory(_ category: String?) {
        self.selectedCategory = category
    }
    
    private func generateMockData() -> [FoodModel] {
        return [
            FoodModel(
                name: "Grilled Salmon",
                image: "salmon_image",
                price: 1500,
                calories: 367,
                protein: 32,
                carbs: 0,
                fiber: 0,
                fat: 22,
                isPopular: true,
                categories: ["Seafood", "Dinner"],
                availableDays: ["Monday", "Wednesday", "Friday"],
                foodDescription: "Fresh Atlantic salmon grilled to perfection with lemon and herbs."
            ),
            FoodModel(
                name: "Pancakes",
                image: "pancake_image",
                price: 899,
                calories: 450,
                protein: 10,
                carbs: 65,
                fiber: 2,
                fat: 12,
                isPopular: true,
                categories: ["Breakfast"],
                availableDays: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"],
                foodDescription: "Fluffy pancakes served with maple syrup and fresh berries."
            ),
            FoodModel(
                name: "Caesar Salad",
                image: "caesar_salad_image",
                price: 750,
                calories: 320,
                protein: 15,
                carbs: 12,
                fiber: 5,
                fat: 22,
                isPopular: false,
                categories: ["Salad", "Lunch"],
                availableDays: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
                foodDescription: "Crisp romaine lettuce with Caesar dressing, croutons, and parmesan cheese."
            ),
            FoodModel(
                name: "Beef Burger",
                image: "burger_image",
                price: 1200,
                calories: 650,
                protein: 35,
                carbs: 40,
                fiber: 3,
                fat: 38,
                isPopular: true,
                categories: ["Lunch", "Dinner"],
                availableDays: ["Tuesday", "Thursday", "Saturday", "Sunday"],
                foodDescription: "Juicy beef patty with cheese, lettuce, tomato, and special sauce on a brioche bun."
            ),
            FoodModel(
                name: "Margherita Pizza",
                image: "pizza_image",
                price: 1300,
                calories: 850,
                protein: 28,
                carbs: 98,
                fiber: 4,
                fat: 22,
                isPopular: true,
                categories: ["Italian", "Dinner"],
                availableDays: ["Wednesday", "Thursday", "Friday", "Saturday", "Sunday"],
                foodDescription: "Classic pizza with tomato sauce, fresh mozzarella, and basil."
            ),
            FoodModel(
                name: "Avocado Toast",
                image: "avocado_toast_image",
                price: 950,
                calories: 380,
                protein: 12,
                carbs: 35,
                fiber: 8,
                fat: 22,
                isPopular: false,
                categories: ["Breakfast", "Vegetarian"],
                availableDays: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"],
                foodDescription: "Toasted artisan bread topped with smashed avocado, salt, pepper, and red pepper flakes."
            ),
            FoodModel(
                name: "Chicken Stir Fry",
                image: "stir_fry_image",
                price: 1100,
                calories: 420,
                protein: 38,
                carbs: 30,
                fiber: 6,
                fat: 12,
                isPopular: true,
                categories: ["Asian", "Dinner"],
                availableDays: ["Monday", "Wednesday", "Friday"],
                foodDescription: "Tender chicken breast with mixed vegetables in a savory sauce served over rice."
            ),
            FoodModel(
                name: "Greek Yogurt Parfait",
                image: "yogurt_image",
                price: 650,
                calories: 280,
                protein: 18,
                carbs: 30,
                fiber: 4,
                fat: 8,
                isPopular: false,
                categories: ["Breakfast", "Vegetarian"],
                availableDays: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
                foodDescription: "Creamy Greek yogurt layered with granola and fresh berries."
            )
        ]
    }
}
