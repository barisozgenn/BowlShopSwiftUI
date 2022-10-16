//
//  SectionTitleModifier.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 16.10.2022.
//

import SwiftUI

struct SectionTitleModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.white)
    }
}

struct SectionTitleModifier_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            Text("Name")
        }.modifier(SectionTitleModifier())
        
    }
}

