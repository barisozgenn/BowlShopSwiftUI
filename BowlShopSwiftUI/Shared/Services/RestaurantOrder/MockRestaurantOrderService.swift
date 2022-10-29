//
//  MockRestaurantOrderService.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 27.10.2022.
//

import Foundation

import Combine

class MockRestaurantOrderService: OnlineOrderServiceProtocol {
    
    @Published var restaurantOrders : [RestaurantOrderModel] = []
    
    init() {
       fetchData()
    }
    
    internal func fetchData() {
        print("DEBUG : mock req API -> restaurant order")
       
        self.restaurantOrders = [
            RestaurantOrderModel(id: UUID().uuidString, detail: "restaurant order detail", products: [mockProduct(),mockProduct(),mockProduct()], deliveryStatus: .allCases.randomElement()!, createdDate: Date(), updatedDate: Date(), tableName: "tableName"),
            RestaurantOrderModel(id: UUID().uuidString, detail: "restaurant order detail", products: [mockProduct(),mockProduct(),mockProduct()], deliveryStatus: .allCases.randomElement()!, createdDate: Date(), updatedDate: Date(), tableName: "tableName"),
            RestaurantOrderModel(id: UUID().uuidString, detail: "restaurant order detail", products: [mockProduct(),mockProduct(),mockProduct()], deliveryStatus: .allCases.randomElement()!, createdDate: Date(), updatedDate: Date(), tableName: "tableName"),
            RestaurantOrderModel(id: UUID().uuidString, detail: "restaurant order detail", products: [mockProduct(),mockProduct(),mockProduct()], deliveryStatus: .allCases.randomElement()!, createdDate: Date(), updatedDate: Date(), tableName: "tableName")
        ]
        
        print("DEBUG : mock res API -> restaurant order")
    }
    
    
    private func mockFoodIngredient() -> FoodIngredient {
        return FoodIngredient.allCases.randomElement()!
    }
    
    private func mockProduct() -> ProductModel {
        return ProductModel(id: UUID().uuidString, name: "product name", price: 7.99, detail: "product detail", ingredients: [mockFoodIngredient(), mockFoodIngredient(), mockFoodIngredient()])
    }
    
    private func mockUser() -> UserModel {
        return UserModel(id: UUID().uuidString, name: "name", surname: "surname", phone: "123456789", email: "test@test.com", addresses: [mockAddress()], registerDate: Date())
    }
    
    private func mockAddress() -> UserAddressModel {
        return UserAddressModel(id: UUID().uuidString, title: "address title", detail: "address detail", longitude: 29.07, latitude: 41.29, createdDate: Date())
    }
}
