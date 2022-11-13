//
//  ProductModel.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 26.10.2022.
//
import FirebaseFirestoreSwift
import FirebaseFirestore

struct ProductModel: Identifiable, Codable {
    @DocumentID var id: String?
    let name: String
    let price: Double
    let detail: String
    let category: FoodCategory
    let ingredients: [FoodIngredient]
    let portion, fat, protein, carbohydrate, sugar, preparationMinute : Double
    let images: [String]
    let videos: [String]?
    var adminId: String
    let createdDate: Timestamp?
}

enum FoodCategory: String, CaseIterable, Identifiable, Codable {
    case food
    case drink
    
    var id : String { return rawValue}
    
    var title : String {
        switch self {
        case .food:
            return "food"
        case .drink:
            return "drink"
        }
    }
    
}
