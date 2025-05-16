//
//  DashboardView.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 09/05/25.
//
import SwiftUI
import SwiftData

struct DashboardView: View {
    @ObservedObject var contentViewModel: ContentViewModel
    @ObservedObject var cartViewModel: CartViewModel
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Welcome header
                Text("Welcome to Eaturi")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 4)
                
                Text("Your healthy meal planner and tracker")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 20)
                
                // Popular items section
                PopularView(
                    viewModel: FoodViewModel(modelContext: modelContext),
                    contentViewModel: contentViewModel,
                    cartViewModel: cartViewModel
                )
                
                // All foods section
                Text("All Foods")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .padding(.bottom, 8)
                
                FoodView(
                    viewModel: FoodViewModel(modelContext: modelContext),
                    contentViewModel: contentViewModel
                )
            }
        }
        .padding()
    }
}

