//
//  UIApplication.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 29.10.2022.
//

import SwiftUI

extension UIApplication {
    
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
