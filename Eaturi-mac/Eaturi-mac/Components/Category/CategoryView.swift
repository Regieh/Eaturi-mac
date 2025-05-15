//
//  CategoryView.swift
//  Eaturi-mac
//
//  Created on 15/05/25.
//
import SwiftUI

struct CategoryView: View {
    @ObservedObject var viewModel: FoodViewModel
    @ObservedObject var contentViewModel: ContentViewModel
    @Binding var selectedCategory: String?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                CategoryButton(
                    title: "All",
                    isSelected: selectedCategory == nil,
                    action: {
                        selectedCategory = nil
                        viewModel.selectCategory(nil)
                    }
                )
                
                ForEach(viewModel.categories, id: \.self) { category in
                    CategoryButton(
                        title: category,
                        isSelected: selectedCategory == category,
                        action: {
                            selectedCategory = category
                            viewModel.selectCategory(category)
                        }
                    )
                }
            }
            .padding(.vertical, 8)
        }
    }
}

struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .medium)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.15))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    CategoryView(
        viewModel: FoodViewModel(),
        contentViewModel: ContentViewModel(),
        selectedCategory: .constant(nil)
    )
    .padding()
}
