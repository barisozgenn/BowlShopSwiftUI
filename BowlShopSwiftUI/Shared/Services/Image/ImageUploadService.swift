//
//  ImageUploader.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 6.11.2022.
//
#if os(macOS)
import AppKit
#else
import UIKit
#endif
import Firebase
import FirebaseStorage

struct ImageUploadService {
    
    #if os(macOS)
    static func uploadImage(image: NSImage, completion: @escaping(String, String) -> Void){
        
    }
    #else
    static func uploadImage(image: UIImage, imageUploadedType: FirebaseFileType, completion: @escaping(String, String) -> Void){
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
    
}
