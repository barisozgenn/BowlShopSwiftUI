//
//  CartView.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 16.10.2022.
//

import SwiftUI

struct CartView: View {
    
    @StateObject private var vm = CartViewModel()
    @State private var alertShown: Bool = false
    
    var body: some View {
        ZStack{
            // bakcground Colors
            bgColor
            backgroundImage
            
            VStack{
                
                divider
                cartVStack
                
                Spacer()
                
                divider
                addressVStack
                
                divider
                paymentVStack
                
                
            }
            .padding(.horizontal)
            .padding(.bottom, 14)
            
        }
    }
    
    
}

extension CartView {
    private var bgColor : some View {
        ZStack{
            Color.black.ignoresSafeArea()
            LinearGradient(colors: [.gray,.black],
                           startPoint: .bottomTrailing,
                           endPoint: .topLeading)
                .ignoresSafeArea()
                .opacity(0.9)
        }
    }
    private var backgroundImage : some View {
        Image(  withAnimation(.spring()){"smoked-salmon-poke-bowl"})
        .resizable()
        .ignoresSafeArea()
        .blur(radius: 100)
        .opacity(0.7)
    }
    
    private var divider : some View {
        Divider()
            .background(.white.opacity(0.7))
            .padding(.vertical)
    }
    
    private var paymentButtonView : some View {
        HStack{
            HStack(alignment: .bottom,spacing:2){
                Text("$")
                    .font(.subheadline)
                    .offset(y: -3)
                Text(String(vm.cartTotalPrice))
                    .font(.title)
            }
            .foregroundColor(.white)
            .fontWeight(.semibold)
            
            
            Spacer()
            
            Button {
                vm.payButtonPressed()
                alertShown = !vm.canBePost
                
            } label: {
                Text("PAY")
                    .foregroundColor(.white)
                    .withPositiveButtonModifier(frameWidth: 200, backgroundColor: .black.opacity(0.29))
            }
            .withPositiveButtonStyle()
            .alert(isPresented: $alertShown, content: {
                var alertMessage = ""
                for (index, message) in vm.alertMessages.enumerated() {
                    alertMessage += "\(index+1)) \(message)\n"
                }
                return Alert(title: Text("OPPS!"), message: Text(alertMessage))
            })
        }
        
    }
    
    private var cartVStack: some View {
        VStack {
            HStack{
                Text("Cart".uppercased())
                    .withSectionTitleModifier()
                Text(String(vm.productsInCart.count).uppercased())
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            ScrollView(showsIndicators: false){
                LazyVStack(spacing: 7){
                    ForEach(vm.productsInCart, id: \.self) {product in
                        CartCellView(title: product, price: "$14.99", image: "smoked-salmon-poke-bowl")
                            
                    }
                }
            }
            .frame(height: .infinity)
        }
    }
    
    private var addressVStack: some View {
        VStack{
            HStack{
                Text("Delivery".uppercased())
                    .withSectionTitleModifier()
                Text("30m")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            
            // delivery note
            TextField("Delivery Note", text: $vm.deliveryNoteText)
                .padding()
                .background(.white.opacity(0.7))
                .foregroundColor(.black.opacity(0.7))
                .cornerRadius(4)
            
            if vm.userAddresses.isEmpty {
                CartCellView(title: "Add Delivery Address", image: "plus")
            }
            else {
                // address type view
                CartCellView(title: "BO Tower on JBR St 7/29", image: "pin.fill")
            }
            
        }
    }
    private var paymentVStack: some View {
        VStack{
            Text("Payment".uppercased())
                .withSectionTitleModifier()
            
            if vm.userPaymentMethods.isEmpty {
                CartCellView(title: "Add Payment Type", image: "plus")
            }
            else{
                // payment type view
                CartCellView(title: "**** 1234", image: "creditcard.fill")
            }
            
            // add to cart
            paymentButtonView
        }
    }
}
struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}