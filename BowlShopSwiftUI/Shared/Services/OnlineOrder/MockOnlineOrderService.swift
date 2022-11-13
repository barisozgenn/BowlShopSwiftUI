//
//  MockOnlineOrderService.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 27.10.2022.
//

import Foundation
import FirebaseFirestore
import Combine

class MockOnlineOrderService: OnlineOrderServiceProtocol {
    
    @Published var onlineOrders : [OnlineOrderModel] = []
    
    init() {
       fetchData()
    }
    
    internal func fetchData() {
        print("DEBUG : mock req API -> online order")
       
        self.onlineOrders = [
            OnlineOrderModel(id: UUID().uuidString, detail: "order detail will be shown here", products: [mockProduct(), mockProduct()], deliveryStatus: .AllCases().randomElement()!, createdDate: Date(), updatedDate: Date(), user: mockUser(), address: mockAddress()),
            
            OnlineOrderModel(id: UUID().uuidString, detail: "order detail will be shown here", products: [mockProduct(), mockProduct()], deliveryStatus: .AllCases().randomElement()!, createdDate: Date(), updatedDate: Date(), user: mockUser(), address: mockAddress()),
            
            OnlineOrderModel(id: UUID().uuidString, detail: "order detail will be shown here", products: [mockProduct(), mockProduct()], deliveryStatus: .AllCases().randomElement()!, createdDate: Date(), updatedDate: Date(), user: mockUser(), address: mockAddress())
        ]
        
        print("DEBUG : mock res API -> online order")
    }
    
    
    private func mockFoodIngredient() -> FoodIngredient {
        return FoodIngredient.allCases.randomElement()!
    }
    
    private func mockProduct() -> ProductModel {
        return ProductModel(id: UUID().uuidString, name: "product name", price: 7.99, detail: "product detail",
                            category: FoodCategory.food,
                            ingredients: [mockFoodIngredient(), mockFoodIngredient(), mockFoodIngredient()],
                            portion: 0, fat: 0, protein: 0, carbohydrate: 0, sugar: 0,
                            preparationMinute: 0,
                            images: ["0.png"], videos: ["0.mp4"],
                            adminId: "",
                            createdDate: Timestamp())
    }
    
    private func mockUser() -> UserModel {
        return UserModel(id: UUID().uuidString, name: "name", surname: "surname", phone: "123456789", email: "test@test.com", profileImageUrl: "", addresses: [mockAddress()], registerDate: Timestamp())
    }
    
    private func mockAddress() -> UserAddressModel {
        return UserAddressModel(id: UUID().uuidString, title: "address title", detail: "address detail", longitude: 29.07, latitude: 41.29, createdDate: Date())
    }
}
