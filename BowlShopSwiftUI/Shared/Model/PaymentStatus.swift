//
//  PaymentStatus.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 17.10.2022.
//

import SwiftUI

enum PaymentStatus: Int, CaseIterable, Identifiable {
    case noProcess
    case processing
    case success
    case failure
    case completed
    
    var id : Int { return rawValue}
    
    var title : String {
        switch self {
            
        case .processing:
            return "Processing"
        case .success:
            return "Success"
        case .failure:
            return "Fail"
        case .noProcess, .completed:
            return ""
        }
    }
    var backgroundColor : Color {
        switch self {
        case .processing:
            return .gray
        case .success:
            return .green
        case .failure:
            return .red
        case .noProcess, .completed:
            return .clear
        }
    }
}
