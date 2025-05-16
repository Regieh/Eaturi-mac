//
//  AssetLoader.swift
//  Eaturi-mac
//
//  Created on 16/05/25.
//
import SwiftUI

// This utility class helps with image loading and debugging
class AssetLoader {
    // Check if an image exists in the asset catalog
    static func imageExists(named imageName: String) -> Bool {
        return NSImage(named: imageName) != nil
    }
    
    // Log all available image names in the asset catalog for debugging
    static func logAllAvailableImages() {
        // Unfortunately, there's no direct API to list all images in the asset catalog
        // This is a placeholder for you to implement debugging as needed
        print("AssetLoader: Unable to list all assets directly, but you can check specific images")
    }
    
    // Load image with a fallback and debug information
    static func loadImage(named imageName: String?) -> Image {
        guard let name = imageName, !name.isEmpty else {
            print("AssetLoader: No image name provided")
            return Image(systemName: "photo")
        }
        
        if imageExists(named: name) {
            print("AssetLoader: Successfully found image: \(name)")
            return Image(name)
        } else {
            print("AssetLoader: Failed to load image: \(name) - not found in asset catalog")
            return Image(systemName: "photo")
        }
    }
}
