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
    @Published private(set) var availableFilters: [FilterItem] = FilterItem.allCases.filter { $0 != .none }
    @Published private(set) var baseImage: UIImage?
    @Published private(set) var previewImage: UIImage?

    @Published var selectedFilter: FilterItem = .none

    private let history: CommandHistoryService
    private let imageService: CoreImageService = CoreImageService()
    private var cancellables = Set<AnyCancellable>()

    init(history: CommandHistoryService) {
        self.history = history
        history.$state
            .map { $0.baseImage }
            .removeDuplicates()
            .sink { [weak self] img in
                self?.baseImage = img
                self?.previewImage = img
            }
            .store(in: &cancellables)

        $selectedFilter
            .sink { [weak self] filter in
                guard let self = self,
                      let image = self.baseImage else { return }
                if filter == .none {
                    self.previewImage = image
                } else if let output = self.imageService.applyFilter(filter, to: image) {
                    self.previewImage = output
                    let command = ApplyFilterCommand(filter: filter)
                    self.history.perform(command)
                }
            }
            .store(in: &cancellables)
    }

    func applyFilter(_ filter: FilterItem) {
        selectedFilter = filter
    }
}
