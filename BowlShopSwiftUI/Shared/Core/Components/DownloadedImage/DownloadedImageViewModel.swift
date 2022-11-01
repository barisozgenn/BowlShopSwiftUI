//
//  DownloadedImageViewModel.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 1.11.2022.
//

import Foundation

import SwiftUI
import Combine
#if os(macOS)
import Cocoa
#endif
class DownloadedImageViewModel: ObservableObject {
    
#if os(macOS)
    @Published private(set) var image : NSImage? = nil
#elseif os(iOS)
    @Published private(set) var image : UIImage? = nil
#endif
    
    @Published private(set) var isLoading : Bool = false
    
    private let imageName: String
    private let imageCategory : ImageDownloadService.EImageCategory
    
    private let dataService: ImageDownloadService
    private var dataCancellables = Set<AnyCancellable>()
    
    init(imageCategory: ImageDownloadService.EImageCategory, imageName: String) {
        self.imageName = imageName
        self.imageCategory = imageCategory
        
        self.dataService = ImageDownloadService(imageCategory: imageCategory, imageName: imageName)
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers(){
        dataService.$image
            .sink{[weak self] (_) in
                self?.isLoading = false
            }receiveValue: { [weak self] (dowloadedImage) in
                self?.image = dowloadedImage
            }
            .store(in: &dataCancellables)
    }
}
