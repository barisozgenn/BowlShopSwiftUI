//
//  ProductDataServiceProtocol.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 16.10.2022.
//

import Foundation
import Combine
protocol ProductDataServiceProtocol {
    func downloadProductsWithEscaping(completion: @escaping (_ products: [String]) -> ())
    func downloadProductsWithCombine() -> AnyPublisher<[String], Error>
}
