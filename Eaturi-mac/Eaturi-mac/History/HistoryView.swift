//
//  HistoryView.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 14/05/25.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var orders: [OrderModel]
    @ObservedObject var foodViewModel: FoodViewModel
    
    init(foodViewModel: FoodViewModel) {
        self.foodViewModel = foodViewModel
    }
    
    var body: some View {
        VStack {
            Text("Order History")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            if orders.isEmpty {
                Text("No orders yet.")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(orders) { order in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Order")
                                    .font(.headline)
                                
                                // Display UUID string
                                Text("#\(order.id.uuidString.prefix(8))")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
                                Spacer()
                                
                                Text(order.date, formatter: dateFormatter)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Divider()
                            
                            // Order items
                            ForEach(order.items) { item in
                                if let food = foodViewModel.findFood(byId: item.foodId) {
                                    HStack {
                                        Text("\(food.name)")
                                            .fontWeight(.medium)
                                        
                                        Text("×\(item.quantity)")
                                            .foregroundColor(.secondary)
                                        
                                        Spacer()
                                        
                                        Text("$\(String(format: "%.2f", item.price * Double(item.quantity)))")
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(.vertical, 2)
                                }
                            }
                            
                            Divider()
                            
                            // Order summary
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Total")
                                        .font(.headline)
                                    
                                    Text("\(order.totalCalories) calories")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Text("$\(String(format: "%.2f", order.totalPrice))")
                                    .font(.title3)
                                    .fontWeight(.bold)
                            }
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal, 2)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.windowBackgroundColor))
                                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                        )
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }
                .listStyle(PlainListStyle())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .onAppear {
            if foodViewModel.foods.isEmpty {
                foodViewModel.loadFoodsFromContext(modelContext)
            }
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}

// Updated extension for FoodViewModel to find food by UUID
extension FoodViewModel {
    func findFood(byId id: UUID) -> FoodModel? {
        foods.first(where: { $0.id == id })
    }
    
    func loadFoodsFromContext(_ modelContext: ModelContext) {
        let fetchDescriptor = FetchDescriptor<FoodModel>()
        do {
            foods = try modelContext.fetch(fetchDescriptor)
            filteredItems = foods
            print("Loaded foods from context: \(foods.map { ($0.id, $0.name, $0.price) })")
        } catch {
            print("Error loading foods from context: \(error)")
        }
    }
}
