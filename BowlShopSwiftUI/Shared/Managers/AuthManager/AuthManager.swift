//
//  AuthManager.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 6.11.2022.
//

import Firebase

class AuthManager {
    
    var userSession: Firebase.User?
    
    static let shared = AuthManager()
    
    init() {
        #if os(macOS)
        FirebaseApp.configure()
        #endif
        userSession = Auth.auth().currentUser
    }
    
    func signOut(){
        userSession = nil
        try? Auth.auth().signOut()
    }
    
    func fetchUserProfile(completion: @escaping (_ userProfile: UserModel) -> ()){
        guard let uid = userSession?.uid else {return}
        
        COLLECTION_USER_PROFILE.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: UserModel.self) else {return}
            completion(user)
          
        }
    }
}
