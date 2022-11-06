//
//  String.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 6.11.2022.
//

import Foundation

extension String {
    var isValidEmail: Bool {
            NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
        }
}
