//
//  CartCellView.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 16.10.2022.
//

import SwiftUI

struct CartCellView: View {
    
    let title: String
    var price: String? = nil
    let image: String
    
    var body: some View {
        VStack(spacing: 10){
            HStack(spacing: 14){
                
                if price != nil {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .cornerRadius(4)
                        .padding()
                }else {
                    Image(systemName: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 14)
                        .padding()
                    
                }
                
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fontWeight(.bold)
                    .font(.headline)
                    .lineLimit(1)
                
                Spacer()
                
                if price != nil {
                    Text(price ?? "")
                        .fontWeight(.bold)
                        .font(.headline)
                        .lineLimit(1)
                    Image(systemName: "minus.circle.fill")
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.gray)
                }else {
                    Image(systemName: "chevron.right")
                        .fontWeight(.bold)
                        .padding()
                }
                
            }
        }
        .frame(height: 50, alignment: .leading)
        .background(Color.black.opacity(0.29))
        .cornerRadius(4)
        .foregroundColor(.white)
    }
}

struct CartCellView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            CartCellView(title: "title", price: "$2.99", image: "smoked-salmon-poke-bowl3")
            CartCellView(title: "title", image: "creditcard.fill")
        }
        
    }
}
