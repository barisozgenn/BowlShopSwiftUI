//
//  RootViewModel.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 8.11.2022.
//

import Firebase

class RootViewModel: ObservableObject {
    private let authManager = AuthManager.shared
    
    @Published var userSession: Firebase.User?
    @Published var animIsOver = false
    @Published var viewIsLoaded = false

    init(){
        Task{
            self.userSession = authManager.userSession
            try await Task.sleep(nanoseconds: UInt64(5.14 * Double(NSEC_PER_SEC)))
            self.animIsOver = true
            try await Task.sleep(nanoseconds: UInt64(0.7 * Double(NSEC_PER_SEC)))
            self.viewIsLoaded = true
        }
    }
    
}
