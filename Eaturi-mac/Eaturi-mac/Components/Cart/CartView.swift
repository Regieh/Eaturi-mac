//
//  CartView.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 14/05/25.
//
import SwiftUI
import SwiftData

struct CartView: View {
    @ObservedObject var cartViewModel: CartViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var contentViewModel: ContentViewModel // Add to navigate
    
    var body: some View {
        VStack {
            // Header
            HStack {
                Text("Your Cart")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            // Cart is empty view
            if cartViewModel.cart.items.isEmpty {
                VStack(spacing: 20) {
                    Image(systemName: "cart")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                    
                    Text("Your cart is empty")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    
                    Text("Add items from the menu to get started")
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            } else {
                // Debug cart items
                let _ = print("Cart items to display: \(cartViewModel.cart.items.map { ($0.foodId, $0.quantity) })")
                
                // Cart items list
                List {
                    ForEach(cartViewModel.cart.items) { item in
                        if let food = cartViewModel.getFoodForCartItem(item) {
                            HStack(spacing: 12) {
                                // Food image using AssetLoader to debug
                                ZStack {
                                    // Debug print for image loading
                                    let _ = print("Debug - Attempting to load cart image for \(food.name): \(String(describing: food.image))")
                                    // Use a background to make empty frames visible
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.gray.opacity(0.1))
                                        .frame(width: 60, height: 60)
                                    
                                    if let imageName = food.image {
                                        let _ = print("Debug - Loading image asset: \(imageName)")
                                        Image(imageName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 80, height: 80)
                                            .cornerRadius(12, corners: [.topLeft, .bottomLeft])
                                    } else {
                                        let _ = print("Debug - No image available for \(food.name)")
                                        Image(systemName: "photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .padding()
                                            .frame(width: 80, height: 80)
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(12, corners: [.topLeft, .bottomLeft])
                                    }
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(food.name)
                                        .font(.headline)
                                        .lineLimit(1)
                                    
                                    Text("$\(String(format: "%.2f", food.price))")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                    // Add nutrition info with compact style
                                    HStack(spacing: 8) {
                                        NutritionItem(value: "\(food.calories)", unit: "cal", compact: true)
                                    }
                                }
                                
                                Spacer()
                                
                                // Quantity stepper
                                HStack {
                                    Button(action: {
                                        cartViewModel.removeFromCart(food: food)
                                    }) {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundColor(.red)
                                            .font(.system(size: 18))
                                    }
                                    
                                    Text("\(item.quantity)")
                                        .font(.headline)
                                        .frame(minWidth: 24)
                                    
                                    Button(action: {
                                        cartViewModel.addToCart(food: food)
                                    }) {
                                        Image(systemName: "plus.circle.fill")
                                            .foregroundColor(.green)
                                            .font(.system(size: 18))
                                    }
                                }
                                .padding(.horizontal, 4)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                
                // Order summary
                VStack(spacing: 12) {
                    Divider()
                    
                    HStack {
                        Text("Total")
                            .font(.headline)
                        
                        Spacer()
                        
                        Text("$\(String(format: "%.2f", cartViewModel.totalPrice()))")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    
                    Button {
                      contentViewModel.selectedItem = .checkout  // add a `.checkout` case to your enum
                    } label: {
                      Text("Checkout")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                    .buttonStyle(.plain)
                }
                .padding()
            }
        }
        .frame(width: 400, height: 500)
        .onAppear {
            cartViewModel.loadFoods()
            print("CartView appeared with \(cartViewModel.cart.items.count) items") // Debug
        }
    }
}

// Cart button for the sidebar
struct CartButton: View {
    @ObservedObject var cartViewModel: CartViewModel
    @State private var showingCart = false
    @ObservedObject var contentViewModel: ContentViewModel // Add to pass through
    
    var body: some View {
        Button(action: {
            showingCart.toggle()
        }) {
            HStack {
                Image(systemName: "cart.fill")
                Text("Cart")
                Spacer()
                
                if cartViewModel.cart.totalItems() > 0 {
                    Text("\(cartViewModel.cart.totalItems())")
                        .padding(6)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .font(.caption)
                }
            }
        }
        .popover(isPresented: $showingCart) {
            CartView(cartViewModel: cartViewModel, contentViewModel: contentViewModel) // Pass the correct contentViewModel
        }
    }
}
