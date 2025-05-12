//
//  PickerView.swift
//  UndoRedoEditor
//
//  Created by Dima Kolesov on 12.05.2025.
//
import SwiftUI

struct PhotoPickerView: UIViewControllerRepresentable {
    let sourceType: ImageSource
    let onImagePicked: (UIImage) -> Void
    let onError: (ImageError) -> Void
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType.sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onImagePicked: onImagePicked, onError: onError)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let onImagePicked: (UIImage) -> Void
        let onError: (ImageError) -> Void
        
        init(onImagePicked: @escaping (UIImage) -> Void, onError: @escaping (ImageError) -> Void) {
            self.onImagePicked = onImagePicked
            self.onError = onError
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                  didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                onImagePicked(uiImage)
            } else {
                onError(.imageProcessingFailed)
            }
            picker.dismiss(animated: true)
        }
    }
}

