//
//  OrderProtocol.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 26.10.2022.
//

import Foundation
protocol OrderProtocol: Identifiable, Codable {
    var id: String {get}
    var detail: String { get set}
    var products: [ProductModel] { get set}
    var deliveryStatus: DeliveryStatus { get set}
    var createdDate: Date { get }
    var updatedDate: Date { get }
    
    func cartPrice() -> Double
}
