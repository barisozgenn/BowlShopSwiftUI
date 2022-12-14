//
//  ProductDetailViewModel.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 15.10.2022.
//

import FirebaseStorage
import Combine
import SwiftUI
class ProductDetailViewModel : ObservableObject {
    
    @Published var isAvailableInStock: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem : String? = nil
    
    let dataService : ProductDataServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(isAvailableInStock: Bool = true, dataService : ProductDataServiceProtocol = ProductMockDataService(products: nil)) {
        self.isAvailableInStock = isAvailableInStock
        self.dataService = dataService
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
    
    func saveItem(item: String) throws{
        guard !item.isEmpty else { throw DataError.noData }
        
        if let sItem = dataArray.first(where: {$0 == item}) {
            print("item saved: \(sItem)")
        }else {
            throw DataError.itemNotFound
        }
    }
    enum DataError: LocalizedError {
        case noData
        case itemNotFound
    }
    
    func downloadWithEscaping(){
        dataService.downloadProductsWithEscaping { [weak self] returnedProducts in
            self?.dataArray = returnedProducts
        }
    }
    
    func downloadWithCombine(){
        dataService.downloadProductsWithCombine()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedProducts in
                self?.dataArray = returnedProducts
            }
            .store(in: &cancellables)
        
    }
    
    func downloadImage(imageName: String, completion: @escaping (_ productImage: Image) -> ()){
        let ref = Storage.storage().reference(withPath: "\(FirebaseFileType.productImage.folderName)\(imageName)")
        
        ref.getData(maxSize: 1 * 1024 * 1024) {(data, _) in
            
            guard let data = data,
                  let uiImage = UIImage(data: data) else {return}
            
            completion(Image(uiImage: uiImage))
        }
    }
}
