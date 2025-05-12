//
//  EditorMainViewModel.swift
//  UndoRedoEditor
//
//  Created by Dima Kolesov on 12.05.2025.
//

import Foundation
import SwiftUI
import Combine

final class EditorMainViewModel: ObservableObject {
    @Published var displayImage: UIImage?
    
    // ViewModels
    let toolsViewModel: ToolsViewModel = ToolsViewModel()
    
    init(displayImage: UIImage) {
        self.displayImage = displayImage
        
        setupBindings()
    }
    
    private func setupBindings() {
        setupToolbarBindings()
    }
    
    private func setupToolbarBindings() {
        
    }
}
