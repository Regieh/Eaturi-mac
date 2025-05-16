//
//  CategoryView.swift
//  Eaturi-mac
//
//  Created on 15/05/25.
//
import SwiftUI

struct CategoryView: View {
    @ObservedObject var viewModel: FoodViewModel // Changed to FoodViewModel
    @ObservedObject var contentViewModel: ContentViewModel
    @Binding var selectedCategory: String?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(viewModel.categories, id: \.self) { category in
                    Button(action: {
                        if selectedCategory == category {
                            selectedCategory = nil
                            viewModel.filterByCategory(category: nil)
                        } else {
                            selectedCategory = category
                            viewModel.filterByCategory(category: category)
                        }
                    }) {
                        Text(category)
                            .font(.subheadline)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                selectedCategory == category ?
                                    Color.blue :
                                    Color.gray.opacity(0.1)
                            )
                            .foregroundColor(
                                selectedCategory == category ?
                                    Color.white :
                                    Color.primary
                            )
                            .cornerRadius(20)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical, 4)
        }
    }
}

