//
//  FoodDetailView.swift
//  Eaturi-mac
//
//  Created on 15/05/25.
//
import SwiftUI

struct FoodDetailView: View {
    let food: FoodModel
    @ObservedObject var contentViewModel: ContentViewModel
    @State private var quantity = 1
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Image and basic info
                HStack(spacing: 20) {
                    Image(food.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 200)
                        .cornerRadius(12)
                        .clipped()
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(food.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text(food.categories.joined(separator: ", "))
                            .font(.title3)
                            .foregroundColor(.secondary)
                        
                        HStack {
                            Image(systemName: "flame.fill")
                                .foregroundColor(.orange)
                            Text("\(food.calories) calories")
                                .fontWeight(.medium)
                        }
                        
                        Text("$\(food.price)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 8)
                    }
                }
                
                Divider()
                
                // Nutrition Information
                VStack(alignment: .leading, spacing: 12) {
                    Text("Nutrition Information")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 20) {
                        NutritionItem(title: "Protein", value: "\(food.protein)g", icon: "fiberbundle.fill", color: .blue)
                        NutritionItem(title: "Carbs", value: "\(food.carbs)g", icon: "chart.pie.fill", color: .green)
                        NutritionItem(title: "Fiber", value: "\(food.fiber)g", icon: "leaf.fill", color: .green)
                        NutritionItem(title: "Fat", value: "\(food.fat)g", icon: "drop.fill", color: .yellow)
                    }
                }
                
                Divider()
                
                // Description
                VStack(alignment: .leading, spacing: 12) {
                    Text("Description")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text(food.foodDescription)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // Availability
                VStack(alignment: .leading, spacing: 12) {
                    Text("Available Days")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 8) {
                        ForEach(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], id: \.self) { day in
                            let isAvailable = isDayAvailable(shortDay: day)
                            Text(day)
                                .font(.subheadline)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(isAvailable ? Color.blue : Color.gray.opacity(0.2))
                                .foregroundColor(isAvailable ? .white : .gray)
                                .cornerRadius(6)
                        }
                    }
                }
                
                Divider()
                
                // Order section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Order")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 16) {
                        // Quantity Stepper
                        HStack {
                            Text("Quantity:")
                                .fontWeight(.medium)
                            
                            Button(action: {
                                if quantity > 1 {
                                    quantity -= 1
                                }
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                            }
                            .buttonStyle(.borderless)
                            
                            Text("\(quantity)")
                                .font(.title3)
                                .fontWeight(.bold)
                                .frame(minWidth: 30)
                                .multilineTextAlignment(.center)
                            
                            Button(action: {
                                quantity += 1
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                            }
                            .buttonStyle(.borderless)
                        }
                        
                        Spacer()
                        
                        // Total price
                        Text("Total: $\(food.price * quantity)")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        // Add to cart button
                        Button(action: {
                            // Add to cart logic here
                        }) {
                            Text("Add to Cart")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        .buttonStyle(.borderless)
                    }
                }
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: {
                    contentViewModel.navigateToDashboard()
                }) {
                    Image(systemName: "chevron.left")
                    Text("Back to Dashboard")
                }
            }
        }
    }
    
    private func isDayAvailable(shortDay: String) -> Bool {
        let dayMap = [
            "Sun": "Sunday",
            "Mon": "Monday",
            "Tue": "Tuesday",
            "Wed": "Wednesday",
            "Thu": "Thursday",
            "Fri": "Friday",
            "Sat": "Saturday"
        ]
        
        if let fullDay = dayMap[shortDay] {
            return food.availableDays.contains(fullDay)
        }
        return false
    }
}
