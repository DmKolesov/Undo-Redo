//
//  FilterViewModel.swift
//  UndoRedoEditor
//
//  Created by Dima Kolesov on 12.05.2025.
//

import Foundation
import SwiftUI
import Combine

final class FilterViewModel: ObservableObject {
    @Published private(set) var baseImage: UIImage?
    private let service: CoreImageService
    
    init(service: CoreImageService = CoreImageService()) {
        self.service = service
    }
    
    private func setupBindings() {
        
    }
    
    func apply(filter: FilterItem, on image: UIImage) {
        guard let image = baseImage else { return }
//        selectedFilter = filter
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let out = self.service.applyFilter(filter, to: image) {
                DispatchQueue.main.async {
                 
                }
            }
        }
    }
}
