//
//  OnlineOrderModel.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 26.10.2022.
//

import Foundation
struct OnlineOrderModel: Codable, OrderProtocol {
    
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
    
    //MARK: Online Order
    let user: UserModel
    let address: UserAddressModel
    var totalPrice : Double {
        let deliveryFee = 5.99
        return cartPrice() + deliveryFee
    }
}
