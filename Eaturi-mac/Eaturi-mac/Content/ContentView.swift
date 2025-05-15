//
//  ContentView.swift
//  Eaturi-mac
//
//  Created on 15/05/25.
//
import SwiftUI
import SwiftData

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    @StateObject private var foodViewModel = FoodViewModel()
    
    var body: some View {
        NavigationSplitView {
            // Sidebar
            List(selection: $viewModel.selectedItem) {
                NavigationLink(value: ContentViewState.dashboard) {
                    Label("Dashboard", systemImage: "house")
                }
                NavigationLink(value: ContentViewState.history) {
                    Label("History", systemImage: "clock")
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("Eaturi")
            .frame(minWidth: 200)
        } detail: {
            // Detail View
            detailView
        }
    }
    
    @ViewBuilder
    private var detailView: some View {
        switch viewModel.selectedItem {
        case .dashboard:
            DashboardView(contentViewModel: viewModel)
                .navigationTitle("Dashboard")
        case .history:
            HistoryView()
                .navigationTitle("History")
        case .foodDetail(let food):
            FoodDetailView(food: food, contentViewModel: viewModel)
                .navigationTitle(food.name)
        case .none:
            Text("Select a view")
                .font(.largeTitle)
                .foregroundColor(.secondary)
        }
    }
}

struct NutritionItem: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
            
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(minWidth: 80)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}

#Preview{
    ContentView(viewModel: ContentViewModel())
}
