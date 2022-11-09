//
//  TextEditorMultiLineView.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 9.11.2022.
//

import SwiftUI

struct TextEditorMultiLineView: View {
    @Binding var bindText : String
    var placeHolderText: String = "Search..."
    var imageSystemName: String = "magnifyingglass"
    
    var body: some View {
        
        ZStack{
            HStack(alignment: .top){
                Image(systemName: imageSystemName)
                    .foregroundColor(Color(.gray))
                    .padding(0)
                
                TextEditor(text: $bindText)
                    .autocorrectionDisabled(true)
                    .multilineTextAlignment(.leading)
                    .textContentType(.none)
                    .accessibilityElement(children: .combine)
                    .frame(height: 100)
                    .textFieldStyle(.plain)
                    .padding(.top, 14)
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
                Text(bindText.isEmpty ? placeHolderText.capitalized : placeHolderText.uppercased())
                    .font(.headline)
                    .padding(.bottom, 100)
                    .padding(.leading, 48)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(Color(.gray))
            .opacity(bindText.isEmpty ? 0.5 : 1.0)
        }
        .padding(.horizontal)
        .foregroundColor(Color(.darkGray))
        
        
    }
}

struct TextEditorMultiLineView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorMultiLineView(bindText: .constant("test qwerty"))
    }
}
