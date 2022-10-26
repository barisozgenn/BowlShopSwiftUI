//
//  FoodIngredient.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 10.10.2022.
//

import Foundation

enum FoodIngredient: String, CaseIterable, Identifiable, Codable {
    case spicy
    case seafood
    case vegan
    case vegeterian
    case sesame
    case egg
    
    var id : String { return rawValue}
    
    var title : String {
        switch self {
        case .spicy:
            return "spicy"
        case .seafood:
            return "seafood"
        case .vegan:
            return "vegan"
        case .vegeterian:
            return "vegeterian"
        case .sesame:
            return "sesame"
        case .egg:
            return "egg"
        }
    }
    
    var image : String {
        switch self {
        case .spicy:
            return "flame.fill"
        case .seafood:
            return "fish.fill"
        case .vegan:
            return "leaf.fill"
        case .vegeterian:
            return "laurel.leading"
        case .sesame:
            return "aqi.medium"
        case .egg:
            return "microbe.fill"
        }
    }
    
}
