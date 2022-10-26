//
//  SideBarMenu.swift
//  AdminSwiftUI_Mac
//
//  Created by Baris OZGEN on 26.10.2022.
//

import Foundation
enum SideBarMenu: Int, CaseIterable, Identifiable {
    case onlineOrders
    case restaurantOrders
    case products
    case restaurant
    
    var id : Int { return rawValue}
    
    var title : String {
        switch self {
            
        case .onlineOrders:
            return "Online Orders"
        case .restaurantOrders:
            return "Restaurant Orders"
        case .products:
            return "Products"
        case .restaurant:
            return "Restaurant"
        }
    }
    
    var image : String {
        switch self {
            
        case .onlineOrders:
            return "bag.circle"
        case .restaurantOrders:
            return "fork.knife.circle"
        case .products:
            return "leaf.circle"
        case .restaurant:
            return "house.circle"
        }
    }
    
}
