//
//  FilterViewModel.swift
//  UndoRedoEditor
//
//  Created by Dima Kolesov on 12.05.2025.
//

import Foundation
import SwiftUI
import Combine

//final class FilterViewModel: ObservableObject {
//    @Published private(set) var availableFilters: [FilterItem] = FilterItem.allCases.filter { $0 != .none }
//    @Published private(set) var previewImage: UIImage?
//
//    @Published var selectedFilter: FilterItem = .none
//
//    private let history: CommandHistoryService
//    private let imageService: CoreImageService = CoreImageService()
//    private var cancellables = Set<AnyCancellable>()
//
//    init(history: CommandHistoryService) {
//        self.history = history
//    
//        bindHistory()
//        selectedFilterBindings()
//    }
//    
//    private func selectedFilterBindings() {
//        $selectedFilter
//            .sink { [weak self] filter in
//                guard let self = self, let image = self.previewImage else { return }
//                print("Применяем фильтр: \(filter)")
//                if filter == .none {
//                    self.previewImage = image
//                    print("Фильтр не выбран, возвращаем оригинальное изображение.")
//                } else if let output = self.imageService.applyFilter(filter, to: image) {
//                    self.previewImage = output
//                    print("Фильтр применен: \(filter), результат: \(String(describing: output))")
//                    let command = ApplyFilterCommand(filter: filter)
//                    self.history.perform(command)
//                }
//            }
//            .store(in: &cancellables)
//    }
//    
//    private func bindHistory() {
//        history.$state
//            .map { $0.baseImage }
//            .removeDuplicates()
//            .sink { [weak self] img in
//                self?.previewImage = img
//            }
//            .store(in: &cancellables)
//    }
//
//    func applyFilter(_ filter: FilterItem) {
//        selectedFilter = filter
//    }
//}

//
//final class FilterViewModel: ObservableObject {
//    @Published private(set) var previewImage: UIImage?
//    @Published var selectedFilter: FilterItem = .none
//
//    private let history: CommandHistoryService
//    private let service = CoreImageService()
//    private var cancellables = Set<AnyCancellable>()
//
//    init(history: CommandHistoryService) {
//        self.history = history
//        bindBaseImage()
//        bindFilterSelection()
//    }
//
//    private func bindBaseImage() {
//        history.$state
//            .map { $0.baseImage }
//            .compactMap { $0 }
//            .sink { [weak self] base in
//       
//                self?.selectedFilter = .none
//                self?.previewImage = base
//            }
//            .store(in: &cancellables)
//    }
//
//    private func bindFilterSelection() {
//        $selectedFilter
//            .dropFirst()
//            .sink { [weak self] filter in
//                guard let self = self,
//                      let base = self.history.state.baseImage else { return }
//
//                let output = (filter == .none) ? base : (self.service.applyFilter(filter, to: base) ?? base)
//                self.previewImage = output
//
//                // Применяем команду сразу
//                if filter != .none {
//                    let cmd = ApplyFilterCommand(filter: filter)
//                    self.history.perform(cmd)
//                    self.selectedFilter = .none
//                }
//            }
//            .store(in: &cancellables)
//    }
//
//  
//    func applyFilter(_ filter: FilterItem) {
//        selectedFilter = filter
//    }
//
//    var availableFilters: [FilterItem] = FilterItem.allCases.filter { $0 != .none }
//}

final class FilterViewModel: ObservableObject {

    @Published var selectedFilter: FilterItem = .none

    private let history: CommandHistoryService
    private let service = CoreImageService()
    private var cancellables = Set<AnyCancellable>()

    init(history: CommandHistoryService) {
        self.history = history
        bindFilterSelection()
    }

    func applyFilter(_ filter: FilterItem) {
        selectedFilter = filter
    }

    private func bindFilterSelection() {
        $selectedFilter
            .dropFirst()
            .sink { [weak self] filter in
                guard let self = self else { return }
                if filter != .none {
                    self.history.perform(ApplyFilterCommand(filter: filter))
                    self.selectedFilter = .none
                }
            }
            .store(in: &cancellables)
    }

    func applyFiltersChain(_ filters: [FilterItem], to image: UIImage) -> UIImage {
        filters.reduce(image) { result, filter in
            service.applyFilter(filter, to: result) ?? result
        }
    }

    var availableFilters: [FilterItem] = FilterItem.allCases.filter { $0 != .none }
}

