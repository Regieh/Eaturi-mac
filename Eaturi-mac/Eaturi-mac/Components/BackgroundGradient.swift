//
//  BackgroundGradient.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 09/05/25.
//

import SwiftUI
import Foundation

var backgroundGradient: some View {
    LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color("colorSecondary"), location: 0.0),
            .init(color: Color("colorSecondary").opacity(0.3), location: 0.3)
        ]),
        startPoint: .topTrailing,
        endPoint: .bottom
    )
    .edgesIgnoringSafeArea(.all)
}
