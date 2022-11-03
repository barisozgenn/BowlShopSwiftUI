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
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
