//
//  ImagePicker.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 4.11.2022.
//

import SwiftUI

#if os(macOS)

#else
struct ImagePicker: UIViewControllerRepresentable {
   
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else {return}
            
            self.parent.image = image
            self.parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

#endif
