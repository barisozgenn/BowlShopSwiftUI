//
//  ProductModel.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 26.10.2022.
//

struct ProductModel: Identifiable, Codable {
    let id: String
    let name: String
    let price: Double
    let detail: String
    let ingredients: [FoodIngredient]
}
