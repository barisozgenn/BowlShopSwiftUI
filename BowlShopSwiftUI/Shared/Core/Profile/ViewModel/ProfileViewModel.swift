//
//  ProfileViewModel.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 4.11.2022.
//
import Firebase
import FirebaseFirestore

import SwiftUI
import FirebaseStorage

class ProfileViewModel: ObservableObject {
    private let authManager = AuthManager.shared
    
    @Published var userSession: Firebase.User?
    @Published var userProfile: UserModel?
    
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var selectedProfileImage: UIImage?
    @Published var profileImage: Image?
    
    @Published var isUserProfileSaved: Bool?
    
    init(){
        self.userSession = authManager.userSession
        self.isUserProfileSaved = false
        fetchUserData()
    }
    
    func signOut(){
        userSession = nil
        authManager.signOut()
    }
    
    func fetchUserData(){
        
        if let phoneNumber = userSession?.phoneNumber {
            phone = phoneNumber
        }
        
        /*authManager.fetchUserProfile(){[weak self] userProfile in
         self?.userProfile = userProfile
         
         if let userModel = self?.userProfile {
         self?.email = userModel.email
         self?.name = userModel.name
         self?.surname = userModel.surname
         }
         }*/
        guard let uid = userSession?.uid else {return}
        COLLECTION_USER_PROFILE.document(uid).getDocument {[weak self] snapshot, _ in
            guard let userModel = try? snapshot?.data(as: UserModel.self) else {return}
            self?.email = userModel.email
            self?.name = userModel.name
            self?.surname = userModel.surname
            
            let ref = Storage.storage().reference(withPath: "\(FirebaseFileType.profile.folderName)\(userModel.profileImageUrl)")
            
            ref.getData(maxSize: 1 * 1024 * 1024) { data, _ in
                
                guard let data = data,
                      let uiImage = UIImage(data: data) else {return}
                
                self?.profileImage = Image(uiImage: uiImage)
            }
        }
    }
    func saveUserProfile(email:String, name: String, surname: String){
        
        guard let user = userSession else {return}
        
        if !email.isValidEmail ||
            name.count < 2 ||
            surname.count < 2 {
            return
        }
        
        var profileImageUrl = ""
        
        if let selectedProfileImage = selectedProfileImage {
            ImageUploadService.uploadImage(image: selectedProfileImage, imageUploadedType: .profile) { [weak self] (urlString, fileName) in
                
                profileImageUrl = fileName
                
                let userModel = UserModel(name: name, surname: surname, phone: self?.userSession?.phoneNumber ?? "", email: email, profileImageUrl: profileImageUrl, addresses: nil, registerDate: Timestamp())
                
                self?.saveUserData(user: user, userModel: userModel)
                
                if let uiImage = ImageDownloadService(imageCategory: .profileImage, imageName: urlString).image {
                    self?.profileImage = Image(uiImage: uiImage)
                }
                
            }
        }
        else {
            let userModel = UserModel(name: name, surname: surname, phone: userSession?.phoneNumber ?? "", email: email, profileImageUrl: profileImageUrl, addresses: nil, registerDate: Timestamp())
            
            saveUserData(user: user, userModel: userModel)
        }
    }
    
    private func saveUserData(user: Firebase.User, userModel: UserModel){
        /*let data = [
         "email": email,
         "phone": user.phoneNumber,
         "name": name,
         "surname": surname,
         "profileImageUrl": profileImageUrl
         ]*/
        
        try? COLLECTION_USER_PROFILE.document(user.uid).setData(from: userModel, merge: true){ [weak self] error in
            if let error = error {
                print("DEBUG: Error writing document: \(error.localizedDescription)")
                return
            }
            self?.userSession = user
            self?.userProfile = userModel
            self?.isUserProfileSaved = true
        }
    }
    
}
