//
//  EditProductView.swift
//  AdminSwiftUI_Mac
//
//  Created by Baris OZGEN on 26.10.2022.
//

import SwiftUI

struct EditProductView: View {
    @State private var textfieldString = "The first month of your **subscription** is free."
    @State private var isPresented = true
    
    var body: some View {
        VStack{
            Text(analysisText(text: textfieldString))
            /*Text("_Italic Text_")
                   Text("**Bold Text**")
                   Text("*Another Italic Text*")
                   Text("~Strikethrough Text~")
                   Text("[baris](www.google.com)")*/
            TextEditor(text: $textfieldString)
                .autocorrectionDisabled(true)
                .multilineTextAlignment(.leading)
                .textContentType(.none)
                .accessibilityElement(children: .combine)
        }
        
            
    }
}

extension EditProductView {

    func analysisText(text: String) -> AttributedString {
        
        var attributedString = AttributedString(text)
        
        let range = attributedString.range(of: "free", locale: Locale(identifier: "en_US"))!
        attributedString[range].underlineStyle = Text.LineStyle(pattern: .solid, color: .pink)
        attributedString[range].font = .body.bold()
        attributedString[range].foregroundColor = .orange
        attributedString[range].baselineOffset = 7
        
        
        
        return attributedString
    }
}
struct EditProductView_Previews: PreviewProvider {
    static var previews: some View {
        EditProductView()
    }
}
