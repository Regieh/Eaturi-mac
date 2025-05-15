//
//  Eaturi_macApp.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 08/05/25.
//
import SwiftUI

@main
struct Eaturi_macApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel())
                .frame(minWidth: 820, maxWidth: .infinity, minHeight: 600, maxHeight: .infinity)
                .preferredColorScheme(.light)
        }
    }
}

