//
//  FoodView.swift
//  Eaturi-mac
//
//  Created on 15/05/25.
//
import SwiftUI
import SwiftData

struct FoodView: View {
    @ObservedObject var viewModel: FoodViewModel
    @ObservedObject var contentViewModel: ContentViewModel
    @State private var searchText = ""
    @State private var selectedCategory: String? = "All"
    @State private var isListView = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Search Bar
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search foods...", text: $searchText)
                    .onChange(of: searchText) { _, newValue in
                        viewModel.searchItems(query: newValue)
                    }
                    .textFieldStyle(.plain)
                    .foregroundColor(.primary)
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                        viewModel.searchItems(query: "")
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color(.windowBackgroundColor).opacity(0.9))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            
            // Categories and View Toggle
            HStack {
                CategoryView(
                    viewModel: viewModel, // Use the existing viewModel
                    contentViewModel: contentViewModel,
                    selectedCategory: $selectedCategory
                )
                .onChange(of: selectedCategory) { _, newValue in
                    viewModel.filterByCategory(category: newValue)
                }
                
                Spacer()
                
                Button(action: {
                    isListView.toggle()
                }) {
                    Image(systemName: isListView ? "square.grid.2x2" : "list.bullet")
                        .foregroundColor(.primary)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                .buttonStyle(.plain)
            }
            .padding(.vertical, 5)
            
            // Food Items
            if isListView {
                VStack(spacing: 12) {
                    ForEach(viewModel.filteredItems) { item in
                        FoodItemCell(food: item) {
                            contentViewModel.navigateToFood(item)
                        }
                    }
                }
            } else {
                ScrollView {
                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: 180, maximum: 220), spacing: 16)],
                        spacing: 16
                    ) {
                        ForEach(viewModel.filteredItems) { item in
                            FoodGridItem(food: item) {
                                contentViewModel.navigateToFood(item)
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
        .onAppear {
            viewModel.filterByCategory(category: selectedCategory)
        }
    }
}

struct FoodGridItem: View {
    var food: FoodModel
    var onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading) {
                if let imageName = food.image {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .frame(height: 140)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(food.name)
                        .font(.headline)
                        .lineLimit(1)
                    
                    Text("\(food.calories) cal • \(food.protein)g protein")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("$\(String(format: "%.2f", food.price))")
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, 4)
                .padding(.vertical, 8)
            }
            .background(Color(.windowBackgroundColor))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
        }
        .buttonStyle(.plain)
    }
}

struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.1))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    let container = try! ModelContainer(for: FoodModel.self, CartModel.self, CartItem.self)
    let modelContext = container.mainContext
    
    let foodViewModel = FoodViewModel(modelContext: modelContext)
    return FoodView(
        viewModel: foodViewModel,
        contentViewModel: ContentViewModel()
    )
    .frame(width: 600, height: 600)
    .preferredColorScheme(.light)
    .modelContainer(container)
}
