//
//  OnlineOrderService.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 27.10.2022.
//

import Foundation
import Combine

class OnlineOrderService: OnlineOrderServiceProtocol {
    
    @Published var onlineOrders = [OnlineOrderModel]()
    
    var dataSubscription: AnyCancellable?
    
    init() {
       fetchData()
    }
    
    internal func fetchData(){
        let urlString = ""
        
        guard let url = URL(string: urlString) else {return}
        
        print("DEBUG : req API -> online order")
        dataSubscription = NetworkManager.download(url: url)
            .decode(type: [OnlineOrderModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion ,
                  receiveValue: {[weak self] (returnedResponse) in
                
                self?.onlineOrders = returnedResponse
                self?.dataSubscription?.cancel()
                print("DEBUG : res API -> online order")
            })
    }
}
