//
//  View.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 11.10.2022.
//

import SwiftUI

extension View {
    
    func withPositiveButtonModifier(frameWidth: Double, backgroundColor: Color) -> some View {
        modifier(PositiveButtonModifier(frameWidth: frameWidth, backgroundColor: backgroundColor))
    }
    
    func withPositiveButtonStyle(scaleValue : CGFloat = 0.9) -> some View {
        buttonStyle(PositiveButtonStyle(scaleValue: scaleValue))
    }
}
