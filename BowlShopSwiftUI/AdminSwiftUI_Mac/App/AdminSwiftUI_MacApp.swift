//
//  AdminSwiftUI_MacApp.swift
//  AdminSwiftUI_Mac
//
//  Created by Baris OZGEN on 26.10.2022.
//

import SwiftUI

@main
struct AdminSwiftUI_MacApp: App {
    // register app delegate for Firebase setup
     @NSApplicationDelegateAdaptor(FirebaseAppDelegate.self) var delegate
    private let authManager = AuthManager.shared

    var body: some Scene {
        WindowGroup {
            if authManager.userSession == nil {
                LoginView()
            }
            else {
                EditProductView()
            }
        }
    }
}
