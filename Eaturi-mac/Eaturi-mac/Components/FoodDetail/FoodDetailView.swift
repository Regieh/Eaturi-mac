//
//  FoodDetailView.swift
//  Eaturi-mac
//
//  Created on 15/05/25.
//

import SwiftUI
import SwiftData

struct FoodDetailView: View {
    let food: FoodModel
    let contentViewModel: ContentViewModel
    let cartViewModel: CartViewModel
    @State private var quantity = 1
    @State private var showAddedToCart = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Food image (placeholder)
                let _ = print("Debug - FoodDetailView image for \(food.name): \(food.image ?? "nil")")
                if let imageName = food.image, !imageName.isEmpty {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                        .cornerRadius(12)
                        .onAppear {
                            print("Debug - DetailView attempting to load image: \(imageName)")
                        }
                        .background(Color.gray.opacity(0.1)) // Background to see boundaries
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                        .onAppear {
                            print("Debug - DetailView using placeholder for \(food.name)")
                        }
                }
                
                // Food details
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text(food.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Text("$\(String(format: "%.2f", food.price))")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    
                    Text(food.foodDescription)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 8)
                    
                    Text(food.category)
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.blue.opacity(0.1))
                        .foregroundColor(.blue)
                        .cornerRadius(20)
                    
                    Divider()
                    
                    // Nutrition information
                    Text("Nutrition Information")
                        .font(.headline)
                        .padding(.bottom, 4)

                    HStack(spacing: 12) {
                        NutritionItem(value: "\(food.calories)", unit: "cal")
                        Divider().frame(height: 16)
                        
                        NutritionItem(value: "\(food.protein)g", unit: "protein")
                        Divider().frame(height: 16)
                        
                        NutritionItem(value: "\(food.carbs)g", unit: "carbs")
                        Divider().frame(height: 16)
                        
                        NutritionItem(value: "\(food.fat)g", unit: "fat")
                    }

                    Divider()
                    
                    // Available days
                    if !food.availableDays.isEmpty {
                        Text("Available on")
                            .font(.headline)
                            .padding(.bottom, 4)
                        
                        HStack {
                            ForEach(food.availableDays, id: \.self) { day in
                                Text(day)
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.green.opacity(0.1))
                                    .foregroundColor(.green)
                                    .cornerRadius(20)
                            }
                            
                            Spacer()
                        }
                    }
                    
                    // Add to cart section
                    HStack {
                        // Quantity stepper
                        Stepper("Quantity: \(quantity)", value: $quantity, in: 1...10)
                        
                        Spacer()
                        
                        // Add to cart button
                        Button(action: {
                            cartViewModel.addToCart(food: food, quantity: quantity)
                            showAddedToCart = true
                            
                            // Hide the notification after 2 seconds
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                showAddedToCart = false
                            }
                        }) {
                            Text("Add to Cart")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.top, 16)
                }
                .padding()
            }
        }
        .overlay(
            // Added to cart notification
            VStack {
                if showAddedToCart {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text("Added to cart!")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            .animation(.easeInOut, value: showAddedToCart)
            .padding(.top, 20),
            alignment: .top
        )
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button {
                    contentViewModel.navigateToDashboard()
                } label: {
                    Label("Back", systemImage: "chevron.left")
                }
            }
        }
    }
}
