//
//  ProductDetailView.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 10.10.2022.
//

import SwiftUI

struct ProductDetailView: View {
    @State private var selectedTab = 0
    @State private var ingredientsViewShown = false
    
    @State private var isFavorite = false
    @State private var cartCount = 0
    
    var body: some View {
        
        ZStack{
            
            // background linear color
            backgroundColor
            // background state image
            backgroundImage
            
            VStack{
                
                // close, like, cart buttons
                headerView
                
                // show images with tab view
                imageTabView
                // product title and ingredients
                productInformation
                
                Spacer()
            }
        }
        
    }
    
    
    private var backgroundColor : some View {
        LinearGradient(
            colors: [
                .gray,
                .black
            ],
            startPoint: .top,
            endPoint: .bottom)
        .ignoresSafeArea()
    }
    
    private var backgroundImage : some View {
        Image(  withAnimation(.spring()){
            selectedTab == 0 ? "smoked-salmon-poke-bowl" : "smoked-salmon-poke-bowl2"})
        .resizable()
        .ignoresSafeArea()
        .blur(radius: 100)
        .opacity(0.7)
    }
    
    private var headerView : some View {
        HStack(spacing: 29){
            Image(systemName: "chevron.down")
                .resizable()
                .scaledToFit()
                .frame(width: 24)
                .foregroundColor(.white)
            
           Spacer()
            
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .resizable()
                .scaledToFit()
                .frame(width: 24)
                .foregroundColor(.white)
            
            Image(systemName: cartCount > 0 ? "cart.fill" : "cart")
                .resizable()
                .scaledToFit()
                .frame(width: 24)
                .foregroundColor(.white)
            
        }
        .padding(.vertical, 7)
        .padding(.horizontal)
        .background(.black.opacity(0.14))
    }
    
    private var imageTabView : some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab){
                Image("smoked-salmon-poke-bowl")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 292, maxHeight: 292)
                    .clipped()
                    .cornerRadius(7)
                    .tag(0)
                
                Image("smoked-salmon-poke-bowl2")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 292, maxHeight: 292)
                    .clipped()
                    .cornerRadius(7)
                    .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
        }
        .frame(height: 392, alignment: .top)
        .padding(.vertical, -14)
    }
    
    private var productInformation : some View {
        ZStack{
            HStack{
                
                // product title
                Text("salmon poke bowl".capitalized)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2, x: 1, y: 1)
                    .opacity(!ingredientsViewShown ? 1 : 0)
                Spacer()
                
                // ingredients summary view
                HStack{
                    Image(systemName: "flame.fill")
                    Image(systemName: "fish.fill")
                    Image(systemName: "aqi.medium")
                    
                }
                .foregroundColor(.white)
                .scaleEffect(!ingredientsViewShown ? 1 : 0.1)
                .opacity(!ingredientsViewShown ? 1 : 0)
                .onTapGesture {
                    withAnimation(.spring()){ ingredientsViewShown.toggle() }
                }
            }
            .frame(width: 292)
            
            // ingredients view
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                  
                    Divider()
                        .frame(height: 29)
                        .background(.white)
                    
                    HStack{
                        Image(systemName: "flame.fill")
                        Text("spicy".capitalized)
                    }
                    .foregroundColor(Color(.orange))
                    
                    Divider()
                        .frame(height: 29)
                        .background(.white)
                    
                    HStack{
                        Image(systemName: "fish.fill")
                        Text("seafood".capitalized)
                    }
                    .foregroundColor(.cyan)
                    
                    Divider()
                        .frame(height: 29)
                        .background(.white)
                    
                    HStack{
                        Image(systemName: "aqi.medium")
                        Text("sesame".capitalized)
                    }
                    .foregroundColor(.brown)
                    
                    Divider()
                        .frame(height: 29)
                        .background(.white)
                }
            }
            .padding()
            .frame(maxWidth: 292)
            .background(.black.opacity(0.29))
            .cornerRadius(7)
            .opacity(ingredientsViewShown ? 1 : 0)
            .scaleEffect(ingredientsViewShown ? 1 : 0)
            .offset(x: (ingredientsViewShown ? 0 : 129), y:0)
            .onTapGesture {
                withAnimation(.spring()){ ingredientsViewShown.toggle() }
            }
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView()
    }
}
