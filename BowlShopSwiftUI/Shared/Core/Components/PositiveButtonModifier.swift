//
//  PositiveButtonModifier.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 11.10.2022.
//

import SwiftUI

struct PositiveButtonModifier: ViewModifier {
    
    let frameWidth : Double
    let backgroundColor : Color
    
    func body(content: Content) -> some View {
        
        content
            .frame(width: frameWidth, alignment: .center)
            .padding()
            .font(.subheadline)
            .fontWeight(.semibold)
            .background(backgroundColor)
            .border(backgroundColor.opacity(0.29))
            .cornerRadius(4)
    }
}

struct PositiveButtonModifier_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            Text("Name")
            Image(systemName: "arrowtriangle.up.fill")
        }.modifier(PositiveButtonModifier(frameWidth: 200, backgroundColor: .blue)
        )
    }
}
