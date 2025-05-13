//
//  EditorMainView.swift
//  UndoRedoEditor
//
//  Created by Dima Kolesov on 12.05.2025.
//

import Foundation
import SwiftUI

struct EditorMainView: View {
    @State private var showSourcePicker = false
    @State private var showImagePicker = false
    @State private var selectedSource: ImageSource = .library
    
    @StateObject var viewModel = EditorViewModel()
    
    var body: some View {
        Group {
            if viewModel.displayImage != nil {
                EditorView(viewModel: viewModel)
            } else {
                SelectImageView {
                    showSourcePicker.toggle()
                }
            }
        }
        .confirmationDialog("Выберите источник", isPresented: $showSourcePicker) {
            Button("Фото из галереи") {
                selectedSource = .library
                showImagePicker = true
            }
            Button("Камера") {
                selectedSource = .camera
                showImagePicker = true
            }
            Button("Отмена", role: .cancel) {}
        }
        .fullScreenCover(isPresented: $showImagePicker) {
            PhotoPickerView(
                sourceType: selectedSource,
                onImagePicked: { image in
                    viewModel.loadImage(image)
                },
                onError: { error in
                    print("Ошибка выбора изображения: \(error.localizedDescription)")
                }
            )
        }
    }
}
struct EditorMainView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer {
            EditorMainView(viewModel: EditorViewModel())
        }
    }
}
