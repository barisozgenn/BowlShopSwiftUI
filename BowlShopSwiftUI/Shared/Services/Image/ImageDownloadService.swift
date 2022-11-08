//
//  ImageDownloadService.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 20.09.2022.
//

import Foundation
import SwiftUI
import Combine

class ImageDownloadService {
    
#if os(macOS)
    @Published var image: NSImage? = nil
    @Published var imageCategory: EImageCategory
    
    private var imageSubscription: AnyCancellable?
    private let fileManager = LocalFileManager.instance
    private let imageName : String
    
    init(imageCategory : EImageCategory, imageName: String) {
        self.imageCategory = imageCategory
        self.imageName = imageName
        
        getImageFromURL()
    }

    
    private func downloadImageFromURL(){
        
       
        guard let url = URL(string: imageName) else {return}
        
        imageSubscription = NetworkManager.download(url: url)
            .tryMap({ (data) -> NSImage? in
                return NSImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (downlodedImageFromURL) in
                
                guard let self = self, let downlodedImage = downlodedImageFromURL else { return }
                
                self.image = downlodedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImageToLocalFolder(image: downlodedImage, imageName: self.imageName, folderName: self.imageCategory.rawValue)
            })
        
    }
#else
    
    @Published var image: UIImage? = nil
    @Published var imageCategory: EImageCategory
    
    private var imageSubscription: AnyCancellable?
    private let fileManager = LocalFileManager.instance
    private let imageName : String
    
    init(imageCategory : EImageCategory, imageName: String) {
        self.imageCategory = imageCategory
        self.imageName = imageName
        
        getImageFromURL()
    }
    
    
    private func downloadImageFromURL(){
        
       
        guard let url = URL(string: imageName) else {return}
        
        imageSubscription = NetworkManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (downlodedImageFromURL) in
                
                guard let self = self, let downlodedImage = downlodedImageFromURL else { return }
                
                self.image = downlodedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImageToLocalFolder(image: downlodedImage, imageName: self.imageName, folderName: self.imageCategory.rawValue)
            })
        
    }
    
#endif
    
    
    
    private func  getImageFromURL(){
        if let localSavedImage = fileManager.getImage(imageName: imageName, folderName: imageCategory.rawValue){
            image = localSavedImage
            //print("DEBUG: Image From FileManager -> \(imageName)")
        }else {
            downloadImageFromURL()
            //print("DEBUG: Image From URL -> \(imageName)")
        }
    }
    
    enum EImageCategory : String {
        case countryFlag = "country_flag_images"
        case productImage = "product_images"
        case profileImage = "/user/profile_images"
    }
}
