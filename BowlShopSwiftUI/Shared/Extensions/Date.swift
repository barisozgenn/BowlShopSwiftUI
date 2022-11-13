//
//  Date.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 11.11.2022.
//

import Firebase

extension Date {
    func toTimestamp() -> Timestamp {
        return Timestamp(date: self)
    }
}
