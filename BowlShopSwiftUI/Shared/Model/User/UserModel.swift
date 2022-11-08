//
//  UserModel.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 26.10.2022.
//

import FirebaseFirestoreSwift
import FirebaseFirestore

import Foundation

struct UserModel: Identifiable, Codable {
    @DocumentID var id: String?
    let name: String
    let surname: String
    let phone: String
    let email: String
    let profileImageUrl: String
    let addresses: [UserAddressModel]?
    let registerDate: Timestamp?
}

