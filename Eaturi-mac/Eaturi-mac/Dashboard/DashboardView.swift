//
//  DashboardView.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 09/05/25.
//
import SwiftUI

struct DashboardView: View {
    @ObservedObject var contentViewModel: ContentViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Spacer()
                PopularView(viewModel: FoodViewModel(), contentViewModel: ContentViewModel())
                FoodView(viewModel: FoodViewModel(), contentViewModel: contentViewModel)
            }
        }
        .padding()
    }
}

#Preview {
    DashboardView(contentViewModel: ContentViewModel())
}
