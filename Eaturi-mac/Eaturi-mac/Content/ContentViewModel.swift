//
//  ContentViewModel.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 09/05/25.
//
import Foundation
import SwiftUI
import SwiftData

enum ContentViewState: Hashable {
    case dashboard
    case history
    case foodDetail(FoodModel)
    case cart
    case checkout
    
    static func == (lhs: ContentViewState, rhs: ContentViewState) -> Bool {
        switch (lhs, rhs) {
        case (.dashboard, .dashboard):
            return true
        case (.history, .history):
            return true
        case (.cart, .cart):
            return true
        case (.checkout, .checkout):
            return true
        case (.foodDetail(let lhsFood), .foodDetail(let rhsFood)):
            return lhsFood.id == rhsFood.id
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .dashboard:
            hasher.combine(0)
        case .history:
            hasher.combine(1)
        case .cart:
            hasher.combine(2)
        case .checkout:
            hasher.combine(3)
        case .foodDetail(let food):
            hasher.combine(4)
            hasher.combine(food.id)
        }
    }
}

class ContentViewModel: ObservableObject {
    @Published var selectedItem: ContentViewState?
    
    init() {
        self.selectedItem = .dashboard
    }
    
    func navigateToFood(_ food: FoodModel) {
        selectedItem = .foodDetail(food)
    }
    
    func navigateToDashboard() {
        selectedItem = .dashboard
    }
    
    func navigateToCart() {
        selectedItem = .cart
    }
    
    func navigateToHistory() {
        selectedItem = .history
    }
    
    func navigateToCheckout() {
        selectedItem = .checkout
    }
}
