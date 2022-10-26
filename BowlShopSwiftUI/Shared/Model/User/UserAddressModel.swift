//
//  UserAddressModel.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 26.10.2022.
//

import Foundation
struct UserAddressModel: Identifiable, Codable {
    let id: String
    let title: String
    let detail: String
    let longitude, latitude: Double
    let createdDate: Date
}
