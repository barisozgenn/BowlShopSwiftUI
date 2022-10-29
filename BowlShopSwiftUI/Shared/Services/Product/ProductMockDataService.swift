//
//  ProductMockDataService.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 16.10.2022.
//

import Foundation
import Combine

class ProductMockDataService: ProductDataServiceProtocol {
    let products: [String]
    
    init(products: [String]?){
        self.products = products ?? [
            "product 1", "product 2", "product 3"
        ]
    }
    
    func downloadProductsWithEscaping(completion: @escaping (_ products: [String]) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(self.products)
        }
    }
    
    func downloadProductsWithCombine() -> AnyPublisher<[String], Error> {
        Just(products)
            .tryMap({ publishedProducts in
                guard !publishedProducts.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                return publishedProducts
            })
            .eraseToAnyPublisher()
    }
    
    
}
