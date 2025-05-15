//
//  FoodItemCell.swift
//  Eaturi-mac
//
//  Created on 15/05/25.
//

import SwiftUI

struct FoodItemCell: View {
    let item: FoodModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 150)
                .cornerRadius(12)
                .clipped()
                .overlay(
                    Group {
                        if item.isPopular {
                            VStack {
                                HStack {
                                    Spacer()
                                    Text("Popular")
                                        .font(.caption)
                                        .bold()
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.orange)
                                        .cornerRadius(8)
                                        .padding(8)
                                }
                                Spacer()
                            }
                        }
                    }
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(item.categories.joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                
                HStack {
                    Text("$\(item.price)")
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "flame.fill")
                            .foregroundColor(.orange)
                            .font(.caption)
                        Text("\(item.calories) kcal")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
        }
        .background(Color.white.opacity(0.7))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}


#Preview {
    FoodItemCell(item: FoodModel(
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
        foodDescription: "Fluffy pancakes with maple syrup"
    ))
    .frame(width: 180)
    .padding()
}
