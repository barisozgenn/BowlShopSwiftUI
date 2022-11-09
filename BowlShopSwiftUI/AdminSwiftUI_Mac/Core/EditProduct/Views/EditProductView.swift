//
//  EditProductView.swift
//  AdminSwiftUI_Mac
//
//  Created by Baris OZGEN on 26.10.2022.
//

import SwiftUI

struct EditProductView: View {
    @State private var titleText = ""
    @State private var descriptionText = ""

    @State private var portionText = ""
    @State private var sugarText = ""
    @State private var fatText = ""
    @State private var proteinText = ""
    @State private var carbohydrateText = ""
    
    @State private var preparationMinuteText = ""
    
    @State private var priceText = ""
    
    @State private var isPresented = true
    
    var body: some View {
        ScrollView{
            VStack{
                
                titleAndDescriptionView
             
                ingredientView
                
                contentDetailView
                
                
                Button(action: {
                    withAnimation(.spring()){
                      
                    }
                })
                {
                    Text("Save")
                        .font(.headline)
                }
                .keyboardShortcut(.return, modifiers: [])
                .buttonStyle(.borderless)
                .frame(width: 80)
                .foregroundColor(Color(.white))
                .padding()
                .background(.green)
                .cornerRadius(4)
                .padding(.bottom)
                
                
            }
        }
        
            
    }
}

extension EditProductView {

    private var titleAndDescriptionView: some View {
        VStack{
            Text(analysisText(text: "Fill all the blanks in detail to get the customer's attention"))
            Divider()
            TextFieldSingleLineView(bindText: $titleText, placeHolderText: "Product Title", imageSystemName: "pencil.line")
            /*Text("_Italic Text_")
                   Text("**Bold Text**")
                   Text("*Another Italic Text*")
                   Text("~Strikethrough Text~")
                   Text("[baris](www.google.com)")*/
            TextEditorMultiLineView(bindText: $descriptionText, placeHolderText: "Product Detail", imageSystemName: "pencil.line")
            TextFieldSingleLineView(bindText: $priceText, placeHolderText: "Product Price", imageSystemName: "eurosign")
        }
    }
    private var ingredientView: some View {
        VStack(alignment: .leading){
            Divider()
            Text("Ingredients")
                .foregroundColor(.gray)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(FoodIngredient.allCases, id: \.id){ ingredient in
                        HStack{
                            Toggle(isOn: .constant(false), label: {
                                HStack{
                                    Image(systemName: ingredient.image)
                                    Text(ingredient.title.capitalized)
                                }
                            })
                            .toggleStyle(.checkbox)
                            .foregroundColor(.gray)
                        }
                        .padding(.all, 4)
                        .background(.white.opacity(0.92))
                        .cornerRadius(4)
                    }
                }
                    
                }
            .frame(height: 35)
        }
        .padding()
    }
    
    private var contentDetailView: some View {
        VStack(alignment: .leading){
            Divider()
            Text("Food Contents Detail (gr)")
                .foregroundColor(.gray)
            
            HStack(alignment: .top){
                VStack{
                    TextFieldSingleLineView(bindText: $portionText, placeHolderText: "Portion", imageSystemName: "fork.knife")
                    TextFieldSingleLineView(bindText: $proteinText, placeHolderText: "Protein", imageSystemName: "tray.and.arrow.down")
                    TextFieldSingleLineView(bindText: $carbohydrateText, placeHolderText: "Carbohydrate", imageSystemName: "tray.and.arrow.down")
                }
                VStack{
                    TextFieldSingleLineView(bindText: $fatText, placeHolderText: "Fat", imageSystemName: "tray.and.arrow.down")
                    TextFieldSingleLineView(bindText: $sugarText, placeHolderText: "Sugar", imageSystemName: "tray.and.arrow.down")
                    
                    TextFieldSingleLineView(bindText: $preparationMinuteText, placeHolderText: "Preparation Minutes", imageSystemName: "clock.badge")
                }
                
            }
        }
        .padding()
    }
    func analysisText(text: String) -> AttributedString {
        
        var attributedString = AttributedString(text)
        
        let range = attributedString.range(of: "detail", locale: Locale(identifier: "en_US"))!
        attributedString[range].underlineStyle = Text.LineStyle(pattern: .solid, color: .pink)
        attributedString[range].font = .body.bold()
        attributedString[range].foregroundColor = .orange
        attributedString[range].baselineOffset = 3
        
        
        
        return attributedString
    }
}
struct EditProductView_Previews: PreviewProvider {
    static var previews: some View {
        EditProductView()
    }
}
