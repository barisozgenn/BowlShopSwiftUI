//
//  ProductDetailViewModel.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 15.10.2022.
//

import Foundation

class ProductDetailViewModel : ObservableObject {
    
    @Published var isAvailableInStock: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem : String? = nil
    
    init(isAvailableInStock: Bool) {
        self.isAvailableInStock = isAvailableInStock
    }
    
    func addItem(item: String){
        guard !item.isEmpty else {return}
        self.dataArray.append(item)
    }
    
    func selectItem(item: String){
        if let sItem = dataArray.first(where: {$0 == item}) {
            selectedItem = sItem 
        }
        else {
            selectedItem = nil
        }
    }
}
