//
//  NutritionItem.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 16/05/25.
//
import SwiftUI

struct NutritionItem: View {
    var value: String
    var unit: String
    var compact: Bool = false
    
    var body: some View {
        VStack(spacing: 2) {
            Text(value)
                .font(compact ? .caption : .footnote)
                .fontWeight(.medium)
            
            Text(unit)
                .font(compact ? .caption2 : .caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 2)
        .padding(.horizontal, compact ? 2 : 4)
    }
}
