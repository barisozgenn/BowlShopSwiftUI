//
//  ProductDetailView.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 12.10.2022.
//

import SwiftUI
import AVKit

struct ProductDetailView: View {
    
    @State private var selectedTab = 0
    @State private var ingredientsViewShown = false
    @State private var productExtraInformationViewShown = false
    
    @State private var isFavorite = false
    @State private var cartCount = 0
    
    @State private var isDescriptionExpanded: Bool = false
    private let descriptionText = "Salmon Poke Bowl is made with sweet savory marinated salmon that is seared to perfection and served in a bowl with fresh veggies and rice!"
    
    @State private var imageFrame: [CGFloat] = [84.0, 92.0]
    private let viewWidth = UIScreen.main.bounds.width - 72.0
    private let productExtraInformationViewY = UIScreen.main.bounds.height
    
    @State var viewState = CGSize.zero
    
    @State var videoPlayer = AVPlayer(url: Bundle.main.url(forResource: "video1", withExtension: "mp4")!)
    
    @State var videoPlayerCurrentTime : Double = 3.0
    
    var body: some View {
        ZStack{
            // background linear color
            backgroundColor
            // background state image
            backgroundImage
            
            VStack{
                // close, like, cart buttons
                headerView
                
                // define AnyLayout -> VStack or HStack
                layout{
                    // show images with tab view
                    //imageTabView
                    // show 180 vide
                    videoPlayerView
                    
                    // product title, ingredients, detail & add to cart
                    VStack(alignment: .trailing){
                        // product title, ingredients, detail
                        productInformation
                            .opacity(viewState.height < -150 ? 0 : 1)
                        
                        Divider()
                            .background(.white.opacity(0.58))
                            .opacity(viewState.height < -145 ? 0 : 1)
                            .padding(.vertical, !productExtraInformationViewShown ? 10 : 0)
                        //add to cart
                        addCartView
                    }
                }
                .frame(width: viewWidth)
                
                Spacer()
            }
            
            productExtraInformation
                .offset(y: viewState.height)
                .gesture(
                    DragGesture().onChanged { value in
                        viewState = value.translation
                        
                        if viewState.height < -270 {
                            productExtraInformationViewShown = true
                            viewState.height = -7
                        }
                        else if viewState.height > 192 { productExtraInformationViewShown = false
                            viewState.height = 7
                        }
                    }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                
                                productExtraInformationViewShown = viewState.height < 0 ? true : false
                                
                                if productExtraInformationViewShown { imageFrame = [92, 92] }
                                else {  imageFrame = [viewWidth + 14, viewWidth + 92] }
                                
                                viewState = .zero
                                
                            }
                        }
                )
            
            /* VStack{
             
             }.sheet(isPresented: $productExtraInformationViewShown){
             productExtraInformation
             .presentationDetents([.height(70), .fraction(0.8)])
             .presentationDragIndicator(.visible)
             }*/
            
        }
    }
    
    private var layout: AnyLayout {
        return !productExtraInformationViewShown ? AnyLayout(VStackLayout()) : AnyLayout(HStackLayout())
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
        HStack{
            TabView(selection: $selectedTab){
                Image("smoked-salmon-poke-bowl")
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .cornerRadius(7)
                    .padding(.horizontal, 7)
                    .tag(0)
                
                Image("smoked-salmon-poke-bowl3")
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .cornerRadius(7)
                    .padding(.horizontal, 7)
                    .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode:  !productExtraInformationViewShown ? .automatic : .never))
            
        }
        .frame(width: imageFrame.first, height:  imageFrame.last)
        .padding(.vertical, productExtraInformationViewShown ? 10 : -14)
        .onAppear{
            withAnimation(.spring()){
                imageFrame = [viewWidth + 14, viewWidth + 92]
            }
        }
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
                    
                    
                    if !productExtraInformationViewShown {
                        
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
                }
                
                if !productExtraInformationViewShown {
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
            }
            .opacity(!ingredientsViewShown ? 1 : 0)
            
            if !productExtraInformationViewShown {
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
        }
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
            
            if !productExtraInformationViewShown {
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Add to Card")
                        .foregroundColor(.white)
                        .withPositiveButtonModifier(frameWidth: 200, backgroundColor: .black.opacity(0.29))
                }
                .withPositiveButtonStyle()
            }
        }
        .opacity(viewState.height > -80 ? 1 : 0)
    }
    
    private var productExtraMenu : some View {
        HStack{
            Text("Food Content")
                .onTapGesture {
                    productExtraInformationViewShown.toggle()
                }
            Spacer()
            Text("Drinks and Sauces")
                .onTapGesture {
                    productExtraInformationViewShown.toggle()
                }
        }
        .foregroundColor(.white)
        .font(.headline)
        .padding(.vertical, 14)
    }
    private var capsule : some View {
        Capsule()
            .foregroundColor(Color.gray.opacity(0.5))
            .frame(width: 40, height: 7)
            .padding(.top, 10)
    }
    
    private var productExtraInformation : some View {
        
        ZStack {
            Color.black.opacity(productExtraInformationViewShown ? 0.07 : 0.29)
            VStack{
                capsule
                productExtraMenu
                
                VStack{
                    Text("\(viewState.height)")
                }
                .frame(height: 60)
                Spacer()
            }
            .frame(width: viewWidth)
        }
        .cornerRadius(productExtraInformationViewShown ? 0 : 29)
        .offset(y: productExtraInformationViewShown ? 158 : productExtraInformationViewY - 150)
    }
    
    private var videoPlayerView : some View {
        VStack{
            VideoPlayer(player: videoPlayer)
                .frame(width: imageFrame.first, height: imageFrame.first, alignment: .center)
                .cornerRadius(14)
                .onAppear{
                    videoPlayer.isMuted = true
                    
                    withAnimation(.spring()){
                        imageFrame = [viewWidth + 14, viewWidth + 92]
                        
                    }
                }
                .disabled(true)
            
            if !productExtraInformationViewShown{
                Slider(value: $videoPlayerCurrentTime, in: 0...6, step: 0.05){}
            minimumValueLabel: {Image(systemName: "chevron.left")}
            maximumValueLabel: {Image(systemName: "chevron.right")}
                    .frame(height: 60)
                    .blendMode(.softLight)
                    .foregroundColor(.white)
                    .tint(.clear)
                    .onChange(of: videoPlayerCurrentTime){ t in
                        
                        let seekTime = CMTime(seconds: t, preferredTimescale: Int32(NSEC_PER_SEC))
                        
                        videoPlayer.seek(to: seekTime, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
                    }
            }
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView()
    }
}
