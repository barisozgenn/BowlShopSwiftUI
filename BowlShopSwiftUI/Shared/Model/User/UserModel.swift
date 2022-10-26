//
//  UserModel.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 26.10.2022.
//

import Foundation
struct UserModel: Identifiable, Codable {
    let id: String
    let name: String
    let surname: String
    let phone: String
    let email: String
    let addresses: [UserAddressModel]
    let registerDate: Date
}
