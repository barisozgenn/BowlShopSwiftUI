//
//  BowlShopSwiftUIApp.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 1.10.2022.
//

import SwiftUI

@main
struct BowlShopSwiftUIApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(FirebaseAppDelegate.self) var delegate
    
    let userLogin: Bool
    
    init(){
        self.userLogin = CommandLine.arguments.contains("-UITest_userLogin") ? true : false
        let userHasAddress = ProcessInfo.processInfo.environment["-UITest_userHasAddress"] == "true" ? true : false
        let userHasPaymentMethod = ProcessInfo.processInfo.environment["-UITest_userHasPaymentMethod"] == "true" ? true : false
        print("DEBUG: did user login: \(userLogin)")
        print("DEBUG: user has address: \(userHasAddress)")
        print("DEBUG: user has payment method: \(userHasPaymentMethod)")
        
        
        
    }
    
    var body: some Scene {
        WindowGroup {
            if let _ = AuthManager.shared.userSession {
                ProductDetailView()
            } else {
                LoginView()
            }
        }
    }
}
