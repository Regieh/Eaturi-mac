//
//  PopularView.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 09/05/25.
//
import SwiftUI
import SwiftData

struct PopularView: View {
    @ObservedObject var viewModel: FoodViewModel
    @ObservedObject var contentViewModel: ContentViewModel
    @ObservedObject var cartViewModel: CartViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Popular Items")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 8)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.getPopularItems()) { food in
                        PopularFoodCard(
                            food: food,
                            contentViewModel: contentViewModel,
                            cartViewModel: cartViewModel
                        )
                    }
                }
                .padding(.bottom, 8)
            }
        }
        .padding(.horizontal)
    }
}

struct PopularFoodCard: View {
    let food: FoodModel
    let contentViewModel: ContentViewModel
    let cartViewModel: CartViewModel
    @State private var showAddedToCart = false
    @State private var isHovering = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image container
            ZStack(alignment: .bottomLeading) {
                if let imageName = food.image {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 220, height: 160)
                        .clipped()
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 220, height: 160)
                        .overlay(
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .foregroundColor(.gray)
                        )
                }
                
                // Popular tag
                Text("Popular")
                    .font(.caption)
                    .fontWeight(.medium)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(6)
                    .padding(10)
            }
            .frame(width: 220, height: 160)
            .cornerRadius(12, corners: [.topLeft, .topRight])
            
            VStack(alignment: .leading, spacing: 4) {
                Text(food.name)
                    .font(.headline)
                    .lineLimit(1)
                    .padding(.top, 8)
                
                Text("$\(String(format: "%.2f", food.price))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack {
                    HStack(spacing: 4) {
                        Image(systemName: "flame.fill")
                            .font(.caption)
                            .foregroundColor(.orange)
                        
                        Text("\(food.calories) cal")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    // Quick add to cart button
                    Button(action: {
                        cartViewModel.addToCart(food: food)
                        showAddedToCart = true
                        
                        // Hide notification after 2 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showAddedToCart = false
                        }
                    }) {
                        Image(systemName: "cart.badge.plus")
                            .font(.system(size: 16))
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(12)
            .background(Color(.windowBackgroundColor))
        }
        .frame(width: 220)
        .background(Color(.windowBackgroundColor))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .onHover { hovering in
            isHovering = hovering
        }
        .scaleEffect(isHovering ? 1.02 : 1.0)
        .animation(.spring(response: 0.3), value: isHovering)
        .onTapGesture {
            contentViewModel.navigateToFood(food)
        }
        .overlay(
            Group {
                if showAddedToCart {
                    Text("Added to cart")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(6)
                        .background(Color.green)
                        .cornerRadius(6)
                        .transition(.scale.combined(with: .opacity))
                        .padding(6)
                }
            },
            alignment: .topTrailing
        )
    }
}
