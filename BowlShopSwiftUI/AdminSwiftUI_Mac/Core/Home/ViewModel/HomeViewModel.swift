//
//  HomeViewModel.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 13.11.2022.
//

import Firebase

class HomeViewModel: ObservableObject {
    
    @Published var products: [ProductModel] = []
    
    init(){
        fetchProducts()
    }
    
    func fetchProducts(){
        
        COLLECTION_PRODUCT.getDocuments { [weak self] (snapshot, error) in
            if let error = error {
                print("DEBUG: Error writing document: \(error.localizedDescription)")
                return
            }
            guard let documents = snapshot?.documents else {return}
            
            self?.products = documents.compactMap({try? $0.data(as: ProductModel.self)})
        }
    }
}
