//
//  Eaturi_macApp.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 08/05/25.
//
import SwiftUI
import SwiftData

@main
struct EaturiApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel())
        }
        .modelContainer(setupModelContainer())
    }
}

func setupModelContainer() -> ModelContainer {
    do {
        return try ModelContainer(for: FoodModel.self, CartModel.self, CartItem.self)
    } catch {
        print("Failed to create model container: \(error)")
        
        // Delete the store file
        if let storeURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first?.appendingPathComponent("default.store") {
            try? FileManager.default.removeItem(at: storeURL)
            print("Deleted corrupted store file")
            
            // Create fresh store
            return try! ModelContainer(for: FoodModel.self, CartModel.self, CartItem.self)
        }
        
        // Fallback to in-memory store
        return try! ModelContainer(
            for: FoodModel.self, CartModel.self, CartItem.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
    }
}
