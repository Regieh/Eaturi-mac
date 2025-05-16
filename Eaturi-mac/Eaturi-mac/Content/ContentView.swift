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
    @Environment(\.modelContext) private var modelContext
    @State private var cartViewModel: CartViewModel?
    
    var body: some View {
        NavigationSplitView {
            // Sidebar
            VStack {
                List(selection: $viewModel.selectedItem) {
                    NavigationLink(value: ContentViewState.dashboard) {
                        Label("Dashboard", systemImage: "house")
                    }
                    NavigationLink(value: ContentViewState.history) {
                        Label("History", systemImage: "clock")
                    }
                }
                .listStyle(.sidebar)
                
                Spacer()
                
                // Cart button at the bottom
                if let cartViewModel = cartViewModel {
                    CartButton(cartViewModel: cartViewModel, contentViewModel: viewModel)
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                }
            }
            .navigationTitle("Eaturi")
            .frame(minWidth: 200)
        } detail: {
            // Detail View
            detailView
        }
        .onAppear {
            // Initialize cart view model when the content view appears
            cartViewModel = CartViewModel(modelContext: modelContext)
        }
    }
    
    @ViewBuilder
    private var detailView: some View {
        if let cartVM = cartViewModel {
            switch viewModel.selectedItem {
            case .dashboard:
                DashboardView(contentViewModel: viewModel, cartViewModel: cartVM)
                    .navigationTitle("Dashboard")
            case .history:
                HistoryView(foodViewModel: FoodViewModel(modelContext: modelContext))
                    .navigationTitle("History")
            case .foodDetail(let food):
                FoodDetailView(food: food, contentViewModel: viewModel, cartViewModel: cartVM)
                    .navigationTitle(food.name)
            case .cart:
                CartView(cartViewModel: cartVM, contentViewModel: viewModel)
                    .navigationTitle("Cart")
            case .checkout:
                CheckoutView(cartViewModel: cartVM, contentViewModel: viewModel)
                    .navigationTitle("Checkout")
            case .none:
                Text("Select a view")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
            }
        } else {
            ProgressView("Loading...")
        }
    }
}
