//
//  FoodViewModel.swift
//  Eaturi-mac
//
//  Created on 15/05/25.
//
import SwiftUI
import SwiftData

class FoodViewModel: ObservableObject {
    @Published var foods: [FoodModel] = []
    @Published var filteredItems: [FoodModel] = []
    private let categoryViewModel = CategoryViewModel()
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        
        // Check if we need to populate the database
        checkAndPopulateDatabase()
        
        // Load foods from the database
        loadFoodsFromContext()
    }
    
    /// Check if database needs to be populated and do it only once
    private func checkAndPopulateDatabase() {
        let fetchDescriptor = FetchDescriptor<FoodModel>()
        do {
            let existingFoods = try modelContext.fetch(fetchDescriptor)
            if existingFoods.isEmpty {
                // Database is empty, populate it
                let sampleFoods = loadSampleData()
                for food in sampleFoods {
                    modelContext.insert(food)
                }
                try modelContext.save()
                print("Database populated with: \(sampleFoods.map { $0.name })")
            } else {
                print("Database already contains \(existingFoods.count) food items, not repopulating")
            }
        } catch {
            print("Error checking database: \(error)")
        }
    }
    
    /// Returns an array of sample FoodModel instances to populate the database.
    private func loadSampleData() -> [FoodModel] {
        return [
            FoodModel(
                name: "Grilled Chicken Salad",
                foodDescription: "Fresh grilled chicken breast on a bed of mixed greens with cherry tomatoes, cucumber, and balsamic vinaigrette.",
                price: 12.0,
                calories: 350,
                protein: 30,
                carbs: 15,
                fat: 12,
                image: "ayam_bakar",
                category: "Salad",
                popular: true,
                isVegan: false,
                isHealthy: true,
                isLowCalorie: true,
                availableDays: ["Senin", "Selasa", "Rabu", "Kamis", "Jumat"]
            ),
            FoodModel(
                name: "Vegetable Stir Fry",
                foodDescription: "Colorful mix of fresh vegetables stir-fried in a savory sauce served with steamed rice.",
                price: 10.0,
                calories: 280,
                protein: 12,
                carbs: 35,
                fat: 10,
                image: "ayam_bakar",
                category: "Vegan",
                popular: false,
                isVegan: true,
                isHealthy: true,
                isLowCalorie: true,
                availableDays: ["Senin", "Rabu", "Kamis", "Jumat"]
            ),
            FoodModel(
                name: "Beef Burger",
                foodDescription: "Juicy beef patty with lettuce, tomato, cheese, and special sauce on a brioche bun. Served with fries.",
                price: 15.0,
                calories: 650,
                protein: 35,
                carbs: 45,
                fat: 38,
                image: "ayam_bakar",
                category: "Burger",
                popular: true,
                isVegan: false,
                isHealthy: false,
                isLowCalorie: false,
                availableDays: ["Senin", "Selasa", "Rabu", "Kamis", "Jumat"]
            ),
            FoodModel(
                name: "Quinoa Bowl",
                foodDescription: "Protein-packed quinoa bowl with roasted vegetables, avocado, and tahini dressing.",
                price: 14.0,
                calories: 420,
                protein: 15,
                carbs: 60,
                fat: 15,
                image: "ayam_bakar",
                category: "Vegan",
                popular: false,
                isVegan: true,
                isHealthy: true,
                isLowCalorie: false,
                availableDays: ["Senin", "Selasa", "Rabu", "Kamis", "Jumat"]
            ),
            FoodModel(
                name: "Salmon Fillet",
                foodDescription: "Oven-baked salmon fillet with lemon and herbs, served with steamed vegetables.",
                price: 18.0,
                calories: 380,
                protein: 40,
                carbs: 5,
                fat: 22,
                image: "ayam_bakar",
                category: "Protein",
                popular: true,
                isVegan: false,
                isHealthy: true,
                isLowCalorie: false,
                availableDays: ["Senin", "Selasa", "Rabu", "Kamis", "Jumat"]
            )
        ]
    }

    /// Loads all FoodModel instances from the model context into the foods array.
    func loadFoodsFromContext() {
        let fetchDescriptor = FetchDescriptor<FoodModel>()
        do {
            foods = try modelContext.fetch(fetchDescriptor)
            filteredItems = foods
            print("Loaded \(foods.count) foods from context")
        } catch {
            print("Error loading foods: \(error)")
        }
    }

    /// Filters food items based on a search query.
    func searchItems(query: String) {
        if query.isEmpty {
            filteredItems = foods
        } else {
            filteredItems = foods.filter {
                $0.name.lowercased().contains(query.lowercased()) ||
                $0.category.lowercased().contains(query.lowercased())
            }
        }
    }

    /// Filters food items by category or special attributes (Healthy, Vegan, Low-calorie).
    func filterByCategory(category: String?) {
        if category == nil || category == "All" {
            filteredItems = foods
        } else {
            filteredItems = foods.filter {
                $0.category.lowercased() == category!.lowercased() ||
                (category == "Healthy" && $0.isHealthy) ||
                (category == "Vegan" && $0.isVegan) ||
                (category == "Low-calorie" && $0.isLowCalorie)
            }
        }
    }

    func getPopularItems() -> [FoodModel] {
        return foods.filter { $0.popular }
    }
    
    /// Returns a list of available categories.
    var categories: [String] {
        ["All"] + categoryViewModel.categories.map { $0.name }
    }
}
