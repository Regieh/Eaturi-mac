//
//  CheckoutView.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 16/05/25.
//

import SwiftUI
import SwiftData

struct CheckoutView: View {
    @ObservedObject var cartViewModel: CartViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var contentViewModel: ContentViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Checkout")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            if cartViewModel.cart.items.isEmpty {
                Text("Your cart is empty.")
                    .foregroundColor(.secondary)
            } else {
                List {
                    ForEach(cartViewModel.cart.items) { item in
                        if let food = cartViewModel.getFoodForCartItem(item) {
                            HStack {
                                Text(food.name)
                                Spacer()
                                Text("\(item.quantity) x $\(String(format: "%.2f", food.price))")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                
                VStack(spacing: 10) {
                    HStack {
                        Text("Subtotal")
                        Spacer()
                        Text("$\(String(format: "%.2f", cartViewModel.totalPrice()))")
                    }
                    HStack {
                        Text("Total Calories")
                        Spacer()
                        Text("\(calculateTotalCalories()) cal")
                    }
                    HStack {
                        Text("Total")
                            .fontWeight(.bold)
                        Spacer()
                        Text("$\(String(format: "%.2f", cartViewModel.totalPrice()))")
                            .fontWeight(.bold)
                    }
                }
                .padding()
                .background(Color(.windowBackgroundColor).opacity(0.9))
                .cornerRadius(12)
                
                Button(action: {
                    saveOrderToHistory()
                    cartViewModel.clearCart()
                    contentViewModel.navigateToHistory()
                    dismiss()
                }) {
                    Text("Confirm Order")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .buttonStyle(.plain)
            }
            
            Spacer()
        }
        .frame(width: 400, height: 500)
        .padding()
    }
    
    private func calculateTotalCalories() -> Int {
        cartViewModel.cart.items.reduce(0) { total, item in
            if let food = cartViewModel.getFoodForCartItem(item) {
                return total + (food.calories * item.quantity)
            }
            return total
        }
    }
    
    private func saveOrderToHistory() {
        let order = OrderModel(
            id: UUID(),
            date: Date(), items: cartViewModel.cart.items.map { $0 },
            totalPrice: cartViewModel.totalPrice(),
            totalCalories: calculateTotalCalories()
        )
        modelContext.insert(order)
        do {
            try modelContext.save()
            print("Order saved to history: \(order.id)")
        } catch {
            print("Error saving order to history: \(error)")
        }
    }
}
