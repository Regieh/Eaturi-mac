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
    @State private var selectedCategory: String? = nil

    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
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
            .background(Color(Color.white.opacity(0.9)))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            
            CategoryView(
                            viewModel: viewModel,
                            contentViewModel: contentViewModel,
                            selectedCategory: $selectedCategory
                        )
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 200), spacing: 16)],
                    spacing: 16
                ) {
                    ForEach(viewModel.filteredItems) { item in
                        FoodItemCell(item: item)
                            .onTapGesture {
                                contentViewModel.navigateToFoodDetail(food: item)
                            }
                    }
                }
                .padding(.top, 10)
        }
    }
}

struct FoodView_Previews: PreviewProvider {
    static var previews: some View {
        FoodView(
            viewModel: FoodViewModel(),
            contentViewModel: ContentViewModel()
        )
        .frame(width: 600, height: .infinity)
        .preferredColorScheme(.light)
    }
}
