//
//  PopularView.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 09/05/25.
//
import SwiftUI

struct NutrientLabel: View {
    let icon: String
    let value: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: icon)
                .font(.caption2)
                .foregroundColor(color)
            Text(value)
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
        }
    }
}

struct PopularView: View {
    @ObservedObject var viewModel: FoodViewModel
    @ObservedObject var contentViewModel: ContentViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Popular")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button("See All") {
                    // Action to see all popular items
                }
                .font(.subheadline)
                .foregroundColor(.blue)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(viewModel.popularItems) { item in
                        PopularCardView(item: item, isAvailable: isItemAvailable(item))
                            .onTapGesture {
                                contentViewModel.navigateToFoodDetail(food: item)
                            }
                    }
                }
                .padding(.bottom, 8)
            }
        }
    }
    
    private func isItemAvailable(_ item: FoodModel) -> Bool {
        let today = Calendar.current.component(.weekday, from: Date())
        let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        let todayString = weekdays[today - 1]
        return item.availableDays.contains(todayString)
    }
}

struct PopularCardView: View {
    let item: FoodModel
    var isAvailable: Bool = true
    
    var body: some View {
        HStack(spacing: 12) {
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.body)
                    .fontWeight(.medium)
                    .lineLimit(1)
                
                // Calories
                HStack(spacing: 4) {
                    Image(systemName: "flame.fill")
                        .font(.subheadline)
                        .foregroundColor(.orange)
                    Text("\(item.calories) kcal")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 2)
                
                // Price
                HStack(spacing: 8) {
                    Text("$\(item.price)")
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
                .padding(4)
            }
            .padding(.trailing, 8)
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .frame(width: 200, height: 100)
        .grayscale(isAvailable ? 0 : 1)
        .opacity(isAvailable ? 1 : 0.7)
        .padding(4)
        .overlay(
            Group {
                if !isAvailable {
                    VStack {
                        Spacer()
                        Text("Not Available Today")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.black.opacity(0.6))
                            .cornerRadius(8)
                            .padding(.bottom, 8)
                    }
                }
            }
        )
    }
}
