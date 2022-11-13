//
//  EditProductViewModel.swift
//  AdminSwiftUI_Mac
//
//  Created by Baris OZGEN on 10.11.2022.
//

import Firebase

class EditProductViewModel: ObservableObject {
    
    private let authManager = AuthManager.shared
    
    @Published var userSession: Firebase.User?
    
    @Published var defaultImageURL = "photo.on.rectangle.angled"
    @Published var defaultImageURLs: [String] = []
    @Published var isUserPrductSaved = false
    init(){
        self.userSession = authManager.userSession
        defaultImageURLs = [defaultImageURL,defaultImageURL,defaultImageURL,defaultImageURL]
    }
    func selectImage(path: String) {
        for (index,image) in defaultImageURLs.enumerated() {
            if image != defaultImageURL {
                defaultImageURLs[index] = image
                return
            }
        }
    }
    
    func addProduct(product: ProductModel) {
        
        guard let _ = userSession?.uid else {return}
        
        let productId = "p_\(UUID(uuidString: product.name)?.uuidString ?? UUID().uuidString)_\(product.adminId)"
       
        try? COLLECTION_PRODUCT.document(productId).setData(from: product, merge: true){ [weak self] error in
            if let error = error {
                print("DEBUG: Error writing document: \(error.localizedDescription)")
                return
            }
           
            self?.isUserPrductSaved = true
        }
    }
}
