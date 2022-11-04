//
//  ProfileViewModel.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 4.11.2022.
//

import Foundation
class ProfileViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var name: String = ""
    @Published var surname: String = ""
}
