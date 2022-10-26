//
//  DeliveryStatus.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 26.10.2022.
//

import Foundation
enum DeliveryStatus: String, CaseIterable, Identifiable, Codable {
    case preparing
    case onTheWay
    case delivered
    case cancelled
    
    var id : String { return rawValue}
    
    var title : String {
        switch self {
        case .preparing:
            return "Preparing"
        case .onTheWay:
            return "On The Way"
        case .delivered:
            return "Delivered"
        case .cancelled:
            return "Cancelled"
        }
    }
    
    var image : String {
        switch self {
        case .preparing:
            return "fork.knife"
        case .onTheWay:
            return "figure.outdoor.cycle"
        case .delivered:
            return "bag.fill"
        case .cancelled:
            return "xmark.bin.fill"
        }
    }
}
