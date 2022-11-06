//
//  AuthManager.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 6.11.2022.
//

import Firebase

class AuthManager: ObservableObject {
       
    @Published var userSession: Firebase.User?
    
    static let shared = AuthManager()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func signOut(){
        userSession = nil
        try? Auth.auth().signOut()
    }
}
