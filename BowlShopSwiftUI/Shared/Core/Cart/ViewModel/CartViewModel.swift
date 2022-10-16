//
//  CartViewModel.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 16.10.2022.
//

import Foundation

class CartViewModel: ObservableObject{
    @Published var canBePost: Bool = false
    @Published var alertMessages: [String] = []
    
    @Published var deliveryNoteText: String = ""
    
    @Published var productsInCart: [String] = []
    @Published var userAddresses: [String] = []
    @Published var userPaymentMethods: [String] = []
    
    @Published var cartTotalPrice: Double = 14.29
    
    init() {
        
        self.productsInCart = ["a product", "b product", "c product"]
        self.userAddresses = ["BO Tower on JBR St 7/29", "BO Tower on JBR St 7/29"]
        self.userPaymentMethods = ["**** 1234", "**** 5678"]
        
        setPostStatus()
    }
    
    func payButtonPressed(){
        setPostStatus()
        if canBePost {
            
        }
    }
    
    func setPostStatus(){
        alertMessages.removeAll()
        
        guard !productsInCart.isEmpty else {
            alertMessages.append("You need add a product to cart.")
            return
        }
        guard !userPaymentMethods.isEmpty else {
            alertMessages.append("You need add a payment method!")
            return
        }
        guard deliveryNoteText.count < 300 else {
            alertMessages.append("You need add delivery address!")
            return
        }
        
        canBePost = true
    }
}
