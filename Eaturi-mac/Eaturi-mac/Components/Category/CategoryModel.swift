//
//  CategoryModel.swift
//  Eaturi-mac
//
//  Created by Raphael Gregorius on 13/05/25.
//
import SwiftUI

// CategoryModel.swift
import Foundation

struct CategoryModel: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var image: String
    var localName: String
}

