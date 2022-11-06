//
//  ImageUploader.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 6.11.2022.
//

import UIKit
import Firebase
import FirebaseStorage

struct ImageUploader {
    
    #if os(macOS)
    static func uploadImage(image: NSImage, completion: @escaping(String, String) -> Void){
        
    }
    #else
    static func uploadImage(image: UIImage, imageUploadedType: ImageUploadedType, completion: @escaping(String, String) -> Void){
        guard let imageData = image.jpegData(compressionQuality: imageUploadedType.compressValue) else {return}
        
        let fileName = "p_\(NSUUID().uuidString)"
        let ref = Storage.storage().reference(withPath: "\(imageUploadedType.folderName)\(fileName)")
        
        ref.putData(imageData) { _, error in
            if let error = error {
                print("DEBUG: upload is failed: \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { url, _ in
                guard let imageUrl = url?.absoluteString else {return}
                completion(imageUrl, fileName)
            }
        }
    }
    #endif
    
    enum ImageUploadedType: String, CaseIterable, Identifiable {
        case profile
        case product
        
        var id : String { return rawValue}
        
        var compressValue: Double {
            switch self {
            case .profile: return 0.7
            case .product: return 0.14
            }
        }
        
        var folderName: String
        {
           switch self {
           case .profile: return "/user/profile_images/"
           case .product: return "/product/product_images/"
           }
       }
    }
}
