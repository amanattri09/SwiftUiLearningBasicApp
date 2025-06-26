//
//  ImagePickerCustom.swift
//  FirebaseSwiftUIExample
//
//  Created by Aman Attri on 26/06/25.
//

import SwiftUI
import UIKit

struct ImagePickerCustom : UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    var sourceType : UIImagePickerController.SourceType = .camera
    @Binding var selectedImage : UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator : NSObject , UINavigationControllerDelegate , UIImagePickerControllerDelegate {
        let parent : ImagePickerCustom
        
        init(_ parent: ImagePickerCustom) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
}
