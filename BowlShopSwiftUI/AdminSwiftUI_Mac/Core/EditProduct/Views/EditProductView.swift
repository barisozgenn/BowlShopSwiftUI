//
//  EditProductView.swift
//  AdminSwiftUI_Mac
//
//  Created by Baris OZGEN on 26.10.2022.
//

import SwiftUI
import CoreVideo

struct EditProductView: View {
    @StateObject private var vm = EditProductViewModel()
    
    @State private var titleText = ""
    @State private var descriptionText = ""

    @State private var portionText = ""
    @State private var sugarText = ""
    @State private var fatText = ""
    @State private var proteinText = ""
    @State private var carbohydrateText = ""
    
    @State private var preparationMinuteText = ""
    
    @State private var priceText = ""
    
    @State var imagePickerPresented = false

    @State private var selectedProductImages: [NSImage] = []

    var body: some View {
        ScrollView{
            VStack{
                titleAndDescriptionView
             
                ingredientView
                
                contentDetailView
                
                imagesView
                
                Button(action: {
                    withAnimation(.spring()){
                        vm.addProduct(product: ProductModel(name: titleText, price: priceText.toDouble(), detail: descriptionText,category: FoodCategory.food,ingredients: [FoodIngredient.egg, .seafood], portion: portionText.toDouble(), fat: fatText.toDouble(), protein: proteinText.toDouble(), carbohydrate: carbohydrateText.toDouble(), sugar: sugarText.toDouble(), preparationMinute: preparationMinuteText.toDouble(), images: [""], videos: [""], adminId: vm.userSession?.uid ?? "", createdDate: Date().toTimestamp()))
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
    
    private var imagesView: some View {
        VStack(alignment: .leading){
            Divider()
            Text("Photos")
                .foregroundColor(.gray)
            HStack{
                ForEach(vm.defaultImageURLs, id: \.self){ image in
                    HStack{
                        VStack{
                            
                            if image == vm.defaultImageURL {
                                Image(systemName: image)
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color(.lightGray))
                            }else {
                                let imageUrlPath = image
                                if FileManager.default.fileExists(atPath: imageUrlPath) {
                                    let url = NSURL(string: imageUrlPath)
                                    let data = NSData(contentsOf: url! as URL)
                                    let img = NSImage(data: data! as Data)
                                    
                                    Image(nsImage: img!)
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(Color(.lightGray))
                                }
                                
                            }
                        }
                      
                    }
                    .frame(width: 100, height: 100)
                    .cornerRadius(14)
                    .padding()
                    .background(Color(.white).opacity(0.58))
                    .padding()
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
