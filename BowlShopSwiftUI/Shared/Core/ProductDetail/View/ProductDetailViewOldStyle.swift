//
//  ProductDetailView.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 10.10.2022.
//

import SwiftUI

struct ProductDetailViewOldStyle: View {
    @State private var selectedTab = 0
    @State private var ingredientsViewShown = false
    
    @State private var isFavorite = false
    @State private var cartCount = 0
    
    @State private var isDescriptionExpanded: Bool = false
    private let descriptionText = "Salmon Poke Bowl is made with sweet savory marinated salmon that is seared to perfection and served in a bowl with fresh veggies and rice!"
    
    private let imageThumbWidth = 84.0
    private let viewWidth = UIScreen.main.bounds.width - 72.0
    private let viewHeight = UIScreen.main.bounds.height
    
    private let scrollPositionMaxY: CGFloat = UIScreen.main.bounds.height - 229
    private let scrollPositionMinY: CGFloat = 82
    @State private var scrollPositionY: CGFloat = UIScreen.main.bounds.height - 229
    @State private var productExtraInformationViewShown = false
    @State private var scrollDetection = true

    @State private var scrollPos = 0.0
    
    
    var body: some View {
        ZStack{
            // background linear color
            backgroundColor
            // background state image
            backgroundImage
            
            
            productExtraInformation
            
            VStack{
                // close, like, cart buttons
                headerView
                
                // show images with tab view
                imageTabView
                
                // product title, ingredients, detail
                productInformation
                
                Divider()
                    .background(.white.opacity(0.58))
                    .frame(width: viewWidth)
                    .padding(.vertical, 10)
                    .opacity(!productExtraInformationViewShown ? 1 : 0)
                //add to cart
                addCartView
                
                Spacer()
                
            }//Text("\(scrollPos)").foregroundColor(.orange)
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
        HStack(spacing: 0) {
            TabView(selection: $selectedTab){
                Image("smoked-salmon-poke-bowl")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: productExtraInformationViewShown ? imageThumbWidth : viewWidth, maxHeight: productExtraInformationViewShown ? imageThumbWidth :  viewWidth)
                    .clipped()
                    .cornerRadius(7)
                    .tag(0)
                
                Image("smoked-salmon-poke-bowl2")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: productExtraInformationViewShown ? imageThumbWidth :  viewWidth, maxHeight: productExtraInformationViewShown ? imageThumbWidth :  viewWidth)
                    .clipped()
                    .cornerRadius(7)
                    .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode:  !productExtraInformationViewShown ? .automatic : .never))
            
            if productExtraInformationViewShown {
                
                VStack(alignment: .trailing){
                    // product title
                    Text("salmon poke bowl".capitalized)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2, x: 1, y: 1)
                    
                    HStack(alignment: .bottom,spacing:2){
                        Text("$")
                            .font(.subheadline)
                            .offset(y: -3)
                        Text("9.99")
                            .font(.title)
                    }
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                }
                .frame(width: 200, alignment: .trailing)
                .padding()
                .padding(.trailing, 20)
                .opacity(productExtraInformationViewShown ? 1 : 0)
            }
            
        }
        .frame(width: .infinity, height:  productExtraInformationViewShown ? imageThumbWidth : viewWidth + 92, alignment: .top)
        .padding(.vertical, productExtraInformationViewShown ? 10 : -14)
    }
    
    private var productInformation : some View {
        ZStack{
            VStack(alignment: .leading, spacing: 14){
                
                // title & ingredients
                HStack{
                    // product title
                    Text("salmon poke bowl".capitalized)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2, x: 1, y: 1)
                    Spacer()
                    
                    // ingredients summary view
                    HStack{
                        Image(systemName: "flame.fill")
                        Image(systemName: "fish.fill")
                        Image(systemName: "aqi.medium")
                        
                    }
                    .foregroundColor(.white)
                    .scaleEffect(!ingredientsViewShown ? 1 : 0.1)
                    .onTapGesture {
                        withAnimation(.spring()){ ingredientsViewShown.toggle() }
                    }
                }
                
                // product description text
                Text(descriptionText)
                    .font(.subheadline)
                    .foregroundColor(Color(.systemGray5))
                    .lineLimit(isDescriptionExpanded ? nil : 2)
                
                if descriptionText.count > 78 {
                    Text(!isDescriptionExpanded ? "Show More" : "Show Less")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(Color(.systemGray5))
                        .onTapGesture {
                            withAnimation(.spring()){ isDescriptionExpanded.toggle() }
                        }
                }
                
            }
            .opacity(!ingredientsViewShown ? 1 : 0)
            
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
            .background(.black.opacity(0.29))
            .cornerRadius(0)
            .opacity(ingredientsViewShown ? 1 : 0)
            .scaleEffect(ingredientsViewShown ? 1 : 0)
            .offset(x: (ingredientsViewShown ? 0 : 129), y:0)
            .onTapGesture {
                withAnimation(.spring()){ ingredientsViewShown.toggle() }
            }
        }
        .frame(width: viewWidth)
        .offset(
            x: !productExtraInformationViewShown ? 0 : 200,
            y: !productExtraInformationViewShown ? 0 : -200)
        .opacity(!productExtraInformationViewShown ? 1 : 0)
        .disabled(!productExtraInformationViewShown ? false : true)
       
    }
    
    private var addCartView : some View {
        HStack{
            HStack(alignment: .bottom,spacing:2){
                Text("$")
                    .font(.subheadline)
                    .offset(y: -3)
                Text("9.99")
                    .font(.title)
            }
            .foregroundColor(.white)
            .fontWeight(.semibold)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Add to Card")
                    .foregroundColor(.white)
                    .withPositiveButtonModifier(frameWidth: 200, backgroundColor: .black.opacity(0.29))
            }
            .withPositiveButtonStyle()
            //animate when a product is added
        }
        .frame(width: viewWidth)
        .offset(
            x: !productExtraInformationViewShown ? 0 : 800,
            y: !productExtraInformationViewShown ? 0 : -800)
        .opacity(!productExtraInformationViewShown ? 1 : 0)
        .disabled(!productExtraInformationViewShown ? false : true)
    }
    
    private var capsule : some View {
        Capsule()
            .foregroundColor(Color.gray.opacity(0.5))
            .frame(width: 58, height: 7)
            .padding(.top, 10)
            .padding(.bottom, 14)
    }
    
    private var productExtraInformation : some View {
        ScrollView{
            GeometryReader{geo -> AnyView? in
                
                let minY = geo.frame(in: .global)
                    .minY
                scrollPos = minY
                
                if scrollDetection && !productExtraInformationViewShown && minY < 653 {
                    
                    scrollDetection = false
                    
                    withAnimation(.spring()){
                        scrollPositionY = scrollPositionMinY
                        productExtraInformationViewShown = true
                    }
                    
                    DispatchQueue
                        .main
                        .asyncAfter(deadline: .now() + 2.29 ) {
                            scrollDetection = true
                        }
                }
                if scrollDetection && productExtraInformationViewShown && minY > 170 {
                    
                    scrollDetection = false
                    
                    withAnimation(.spring()){
                        scrollPositionY = scrollPositionMaxY
                        productExtraInformationViewShown = false
                    }
                    
                    DispatchQueue
                        .main
                        .asyncAfter(deadline: .now() + 2.29 ) {
                            scrollDetection = true
                        }
                }
                
                return nil
            }
            
            ZStack {
                Color.black.opacity(!productExtraInformationViewShown ? 0.58 : 0.14)
                
                VStack{
                    capsule
                    
                    HStack{
                        Text("Food Content")
                        Spacer()
                        Text("Drinks and Sauces")
                    }
                    .foregroundColor(.white)
                    .font(.headline)
                    
                    ScrollView{
                        Text("Food Content")
                    }
                }
                .frame(width: viewWidth)
            }
            .cornerRadius(29)
            .frame(width: .infinity, height: viewHeight - 192)
            .padding(.top, 58)
        }
        //.background(.cyan)
        .offset(y: scrollPositionY)
        //.background(.blue)
    }
    
}

struct ProductDetailViewOldStyle_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailViewOldStyle()
    }
}
