//
//  ProductCellView.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 13.11.2022.
//

import SwiftUI
import FirebaseStorage

struct ProductCellView: View {
    let product: ProductModel
    
    @State private var productImage: Image = Image("smoked-salmon-poke-bowl")
    
    var body: some View {
        VStack(spacing: -16){
           
            productImage
                .resizable()
                .scaledToFill()
                .cornerRadius(14)
                .frame(width: 180, height: 180)
                .clipped()
            
            VStack(spacing: 0){
                ZStack {
                    productImage
                        .resizable()
                        .blur(radius: 29)
                        .clipped()
                        .opacity(0.29)
                    Text(product.name.uppercased())
                        .foregroundColor(Color(.darkGray))
                        .lineLimit(2)
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()
                    
                }
                .frame(height: 75)
                
                ZStack{
                    productImage
                        .resizable()
                        .blur(radius: 29)
                        .cornerRadius(14)
                        .clipped()
                    HStack(alignment: .bottom,spacing: 0){
                        Text("$")
                            .font(.headline)
                            .offset(y: -1)
                        Text(String(product.price))
                            .lineLimit(1)
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                }
                .background(Color(.darkGray))
            }
            .foregroundColor(.white)
            .cornerRadius(14)
            .clipped()
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(.white))
                    .shadow(
                        color: .black.opacity(0.29),
                        radius: 7,x: 0, y: 7
                    )
            )
        }
        .frame(width: 190, height: 277)
    }
}

extension ProductCellView {
    
    /*func downloadImage(productImageUrl: String){
     let ref = Storage.storage().reference(withPath: "\(FirebaseFileType.productImage.folderName)\(productImageUrl)")
     
     ref.getData(maxSize: 1 * 1024 * 1024) {(data, _) in
     
     guard let data = data,
     let uiImage = UIImage(data: data) else {return}
     
     productImage = Image(uiImage: uiImage)
     }
     }*/
}
struct ProductCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCellView(product: ProductModel(name: "Smoked salmon poke bowl", price: 17.75, detail: "Lorem ipsum dolor set product detail", category: FoodCategory.food, ingredients: [FoodIngredient.egg, .seafood], portion: 350.0, fat: 10.0, protein: 11.0, carbohydrate: 12.0, sugar: 7.0, preparationMinute: 29.0, images: ["smoked-salmon-poke-bowl.jpg"], videos: nil, adminId: "", createdDate: Date().toTimestamp()))
    }
}
