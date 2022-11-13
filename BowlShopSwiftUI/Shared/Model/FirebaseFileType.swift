//
//  FirebaseFileType.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 7.11.2022.
//

import Foundation

enum FirebaseFileType: String, CaseIterable, Identifiable {
    case profile
    case productImage
    case productVideo
    
    var id : String { return rawValue}
    
    var compressValue: Double {
        switch self {
        case .profile: return 0.7
        case .productImage, .productVideo: return 0.14
        }
    }
    
    var folderName: String
    {
        switch self {
        case .profile: return "/user/profile_images/"
        case .productImage: return "/product/images/"
        case .productVideo: return "/product/videos/"

        }
    }
}
