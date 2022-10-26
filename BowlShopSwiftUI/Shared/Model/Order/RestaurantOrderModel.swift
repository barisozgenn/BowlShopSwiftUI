//
//  RestaurantOrderModel.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 26.10.2022.
//

import Foundation
struct RestaurantOrderModel: Codable, OrderProtocol {
    
    //MARK: Order Protocol
    var id: String
    
    var detail: String
    
    var products: [ProductModel]
    
    var deliveryStatus: DeliveryStatus
    
    var createdDate: Date
    
    var updatedDate: Date
    
    internal func cartPrice() -> Double {
        return self.products.map{ $0.price }.reduce(0, +)
    }
    
    //MARK: Restaurant Order
    let tableName: String
    var totalPrice : Double {
        let serviceFee = 0.10
        return cartPrice() + serviceFee
    }
}
