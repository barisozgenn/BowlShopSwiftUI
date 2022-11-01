//
//  DownloadedImageView.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 1.11.2022.
//


import SwiftUI

struct DownloadedImageView: View {
    
    @StateObject var vm : DownloadedImageViewModel
    
    init(imageCategory: ImageDownloadService.EImageCategory, imageName: String) {
        _vm = StateObject(wrappedValue: DownloadedImageViewModel(imageCategory: imageCategory, imageName: imageName))
    }
    
    var body: some View {
        
        if let image = vm.image {
            #if os(macOS)
            Image(nsImage: image)
                .resizable()
                .scaledToFit()
            #elseif os(iOS)
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
            #endif
                    
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "photo.circle.fill")
                    .foregroundColor(.gray)
            }
        
    }
}

struct DownloadedImageView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadedImageView(imageCategory: .countryFlag, imageName: "https://baris_empty")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
