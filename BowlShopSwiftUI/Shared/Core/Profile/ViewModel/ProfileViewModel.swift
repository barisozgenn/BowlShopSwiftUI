//
//  ProfileViewModel.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 4.11.2022.
//

import Firebase
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var userSession: Firebase.User?
    
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var name: String = ""
    @Published var surname: String = ""
    
    @Published var selectedProfileImage: UIImage?
    @Published var profileImage: Image?
    
    private let authManager = AuthManager.shared
    
    init(){
        self.userSession = authManager.userSession
        getUserProfile()
    }
    
    func getUserProfile(){
        if let email = userSession?.email { self.email = email}
        if let phone = userSession?.phoneNumber { self.phone = phone}
        if let name = userSession?.displayName { self.name = name}
        if let surname = userSession?.displayName { self.email = surname}
    }
    
    func signOut(){
        userSession = nil
        authManager.signOut()
    }
    
    func saveUserProfile(){
        
        guard let user = userSession else {return}
        
        if !email.isValidEmail ||
            name.count < 2 ||
            surname.count < 2 {
            return
        }
        
        
        var profileImageUrl = ""
        
        if let selectedProfileImage = selectedProfileImage {
            ImageUploader.uploadImage(image: selectedProfileImage, imageUploadedType: .profile) { [weak self] (urlString, fileName) in
                
                profileImageUrl = fileName
                self?.saveUserData(user: user, profileImageUrl: profileImageUrl)
                
                if let uiImage = ImageDownloadService(imageCategory: .profileImage, imageName: urlString).image {
                    self?.profileImage = Image(uiImage: uiImage)
                }
                
            }
        }
        else {
            saveUserData(user: user)
        }
        
        
        
        
    }
    
    private func saveUserData(user: Firebase.User, profileImageUrl: String = ""){
        let data = [
            "uid": user.uid,
            "email": email,
            "phone": user.phoneNumber,
            "name": name,
            "surname": surname,
            "profileImageUrl": profileImageUrl
        ]
        
        Firestore.firestore().collection("users").document(user.uid).setData(data as [String : Any]){ [weak self] _ in
            self?.userSession = user
        }
    }
    
}
