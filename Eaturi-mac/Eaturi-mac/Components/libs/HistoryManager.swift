import SwiftData
import Foundation

class HistoryManager {
    static func saveOrderHistory(
        cart: [UUID: Int],
        modelContext: ModelContext,
        foodData: [UUID: (price: Int, calories: Int, protein: Int, carbs: Int, fiber: Int, fat: Int)]
    ) {
        var totals = (price: 0, calories: 0, protein: 0, carbs: 0, fiber: 0, fat: 0, totalQuantity: 0)
        
        for (itemID, quantity) in cart {
            if let data = foodData[itemID] {
                totals.price += data.price * quantity
                totals.calories += data.calories * quantity
                totals.protein += data.protein * quantity
                totals.carbs += data.carbs * quantity
                totals.fiber += data.fiber * quantity
                totals.fat += data.fat * quantity
                totals.totalQuantity += quantity
            }
        }
        
        let newRecord = HistoryRecord(
            cart: cart,
            totalPrice: totals.price,
            totalCalories: totals.calories,
            totalProtein: totals.protein,
            totalCarbs: totals.carbs,
            totalFiber: totals.fiber,
            totalFat: totals.fat,
            totalQuantity: totals.totalQuantity
        )
        
        modelContext.insert(newRecord)
        
        do {
            try modelContext.save()
            print("💾 Saved successfully: \(newRecord.id)")
        } catch {
            print("🚨 Save error: \(error.localizedDescription)")
        }
    }
    
    static func fetchOrderHistory(modelContext: ModelContext) -> [HistoryRecord] {
        let descriptor = FetchDescriptor<HistoryRecord>(
            sortBy: [SortDescriptor(\.timestamp, order: .reverse)]
        )
        
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            print("🚨 Fetch error: \(error.localizedDescription)")
            return []
        }
    }
}
