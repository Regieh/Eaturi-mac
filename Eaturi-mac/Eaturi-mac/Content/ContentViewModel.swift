//
//  ContentViewModel.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 09/05/25.
//
import Foundation
import SwiftUI

enum ContentViewState: Hashable {
    case dashboard
    case history
    case foodDetail(FoodModel)
    case none
    
    var name: String {
        switch self {
        case .dashboard: return "Dashboard"
        case .history: return "History"
        case .foodDetail: return "Food Detail"
        case .none: return "None"
        }
    }
}

class ContentViewModel: ObservableObject {
    @Published var selectedItem: ContentViewState = .dashboard
    
    func navigateToFoodDetail(food: FoodModel) {
        selectedItem = .foodDetail(food)
    }
    
    func navigateToDashboard() {
        selectedItem = .dashboard
    }
}
