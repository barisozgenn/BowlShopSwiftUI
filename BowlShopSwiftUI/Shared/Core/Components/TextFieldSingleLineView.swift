//
//  TextFieldSingleLineView.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 4.11.2022.
//

import SwiftUI

struct TextFieldSingleLineView: View {
    @Binding var bindText : String
    var placeHolderText: String = "Search..."
    var imageSystemName: String = "magnifyingglass"
    
    var body: some View {
        
        ZStack{
            HStack{
                Image(systemName: imageSystemName)
                    .foregroundColor(Color(.gray))
                
                TextField(placeHolderText.capitalized, text: $bindText)
                    .disableAutocorrection(true)
                    .overlay(
                        Image(systemName: "xmark.circle.fill")
                            .padding()
                            .offset(x: 14)
                            .opacity(
                                bindText.isEmpty ?
                                0 : 0.6)
                            .onTapGesture {
#if os(iOS)
                                UIApplication.shared.endEditing()
#endif
                                bindText = ""
                            }
                        ,alignment: .trailing
                    )
                    .textFieldStyle(.plain)
            }
            .font(.headline)
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(.white)
                    .shadow(
                        color: .black.opacity(0.14),
                        radius: 1,x: 0, y: 1
                    )
            )
            
            VStack{
                Text(placeHolderText.uppercased())
                    .font(.caption2)
                    .padding(.bottom, 36)
                    .padding(.leading, 48)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .opacity(bindText.isEmpty ? 0.0 : 1.0)
        }
        .padding(.horizontal)
        .foregroundColor(Color(.darkGray))
        
        
    }
}

struct TextFieldSingleLineView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldSingleLineView(bindText: .constant("Asd"))
    }
}
