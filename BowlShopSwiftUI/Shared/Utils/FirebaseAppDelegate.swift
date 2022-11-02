//
//  FirebaseAppDelegate.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 2.11.2022.
//

import SwiftUI
import FirebaseCore

class FirebaseAppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
