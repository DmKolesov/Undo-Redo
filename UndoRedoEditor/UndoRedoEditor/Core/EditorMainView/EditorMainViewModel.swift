//
//  EditorMainViewModel.swift
//  UndoRedoEditor
//
//  Created by Dima Kolesov on 12.05.2025.
//

import Foundation
import SwiftUI
import Combine
import PencilKit

//final class EditorViewModel: ObservableObject {
//    @Published private(set) var state: EditorState?
//    @Published private(set) var canUndo = false
//    @Published private(set) var canRedo = false
//    
//    @Published private(set) var displayImage: UIImage
//
//    let toolsViewModel = ToolsViewModel()
//  
//    
//    var filterVM: FilterViewModel?
//
//    private var history: CommandHistoryService?
//    private var cancellables = Set<AnyCancellable>()
//    
//    init(displayImage: UIImage) {
//        self.displayImage = displayImage
//    }
//
//    func loadImage(_ image: UIImage) {
//   
//        let initialState = EditorState(baseImage: image)
//        let history = CommandHistoryService(initialState: initialState)
//
//        self.state = initialState
//        self.history = history
//
//        self.filterVM = FilterViewModel(history: history)
//
//        bindHistory(history)
//        bindToolsViewModel()
//    }
//
//    func perform(_ command: EditorCommand) {
//        guard let history else {
//            assertionFailure("🚨 История не инициализирована до perform")
//            return
//        }
//        print("✅ Выполнение команды: \(type(of: command))")
//        history.perform(command)
//    }
//
//    func undo() {
//        guard let history else {
//            assertionFailure("🚨 История не инициализирована до undo")
//            return
//        }
//        print("↩️ Undo")
//        history.undo()
//    }
//
//    func redo() {
//        guard let history else {
//            assertionFailure("🚨 История не инициализирована до redo")
//            return
//        }
//        print("↪️ Redo")
//        history.redo()
//    }
//
//    // MARK: - Bindings
//
//    private func bindHistory(_ history: CommandHistoryService) {
//        history.$state
//            .receive(on: RunLoop.main)
//            .sink { [weak self] newState in
//                self?.state = newState
//                print("🧠 Состояние обновлено (undo/redo или команда)")
//            }
//            .store(in: &cancellables)
//
//        history.$canUndo
//            .assign(to: \.canUndo, on: self)
//            .store(in: &cancellables)
//
//        history.$canRedo
//            .assign(to: \.canRedo, on: self)
//            .store(in: &cancellables)
//
//        history.$canUndo
//            .assign(to: \.canUndo, on: toolsViewModel)
//            .store(in: &cancellables)
//
//        history.$canRedo
//            .assign(to: \.canRedo, on: toolsViewModel)
//            .store(in: &cancellables)
//    }
//
//    private func bindToolsViewModel() {
//        toolsViewModel.undoTapped
//            .sink { [weak self] in
//                print("🔁 Кнопка Undo нажата")
//                self?.undo()
//            }
//            .store(in: &cancellables)
//
//        toolsViewModel.redoTapped
//            .sink { [weak self] in
//                print("🔂 Кнопка Redo нажата")
//                self?.redo()
//            }
//            .store(in: &cancellables)
//        
//        toolsViewModel.$showDrawingTools
//            .sink { [weak self] _ in self?.objectWillChange.send() }
//            .store(in: &cancellables)
//        
//        toolsViewModel.$showFilterTools
//            .sink { [weak self] _ in self?.objectWillChange.send() }
//            .store(in: &cancellables)
//    }
//}


//final class EditorViewModel: ObservableObject {
//    // MARK: - Published Properties
//    @Published private(set) var displayImage: UIImage?
//    @Published private(set) var canUndo = false
//    @Published private(set) var canRedo = false
//
//    // MARK: - Sub ViewModels
//    let toolsViewModel = ToolsViewModel()
//    let filterVM: FilterViewModel
//   // let drawingVM: DrawingViewModel
//    // future: let textVM, cropVM, etc.
//
//    // MARK: - Private Properties
//    private let history: CommandHistoryService
//    private var cancellables = Set<AnyCancellable>()
//
//    // MARK: - Initialization
//    init() {
//        // Initialize empty history
//        history = CommandHistoryService(initialState: EditorState())
//        filterVM = FilterViewModel(history: history)
//      //  drawingVM = DrawingViewModel(history: history)
//
//        setupBindings()
//    }
//
//    // MARK: - Public API
//    /// Загружает изображение в редактор
//    func loadImage(_ image: UIImage) {
//        let newState = EditorState(baseImage: image)
//        history.clearHistory()
//        history.state = newState
//    }
//
//    /// Выполнить команду
//    func perform(_ command: EditorCommand) {
//        history.perform(command)
//    }
//
//    /// Undo
//    func undo() { history.undo() }
//
//    /// Redo
//    func redo() { history.redo() }
//
//    // MARK: - Bindings Setup
//    private func setupBindings() {
//        bindHistoryFlags()
//        bindToolActions()
//        bindDisplayLogic()
//    }
//
//    private func bindHistoryFlags() {
//        history.$canUndo
//            .assign(to: \ .canUndo, on: self)
//            .store(in: &cancellables)
//
//        history.$canRedo
//            .assign(to: \ .canRedo, on: self)
//            .store(in: &cancellables)
//
//        history.$canUndo
//            .assign(to: \ .canUndo, on: toolsViewModel)
//            .store(in: &cancellables)
//
//        history.$canRedo
//            .assign(to: \ .canRedo, on: toolsViewModel)
//            .store(in: &cancellables)
//    }
//
//    private func bindToolActions() {
//        toolsViewModel.undoTapped
//            .sink { [weak self] in self?.undo() }
//            .store(in: &cancellables)
//        toolsViewModel.redoTapped
//            .sink { [weak self] in self?.redo() }
//            .store(in: &cancellables)
//    }
//
//    private func bindDisplayLogic() {
//        // Update display on any relevant change
//        Publishers.CombineLatest3(
//            history.$state,
//            toolsViewModel.$currentTool,
//            filterVM.$previewImage
//        )
//        .sink { [weak self] state, tool, preview in
//            self?.updateDisplay(state: state, tool: tool, filterPreview: preview)
//        }
//        .store(in: &cancellables)
//    }
//
//    // MARK: - Display Computation
//    private func updateDisplay(state: EditorState,
//                               tool: ToolsViewModel.ToolMode,
//                               filterPreview: UIImage?) {
//        switch tool {
//        case .filter:
//            displayImage = filterPreview ?? state.baseImage
//
//        case .draw:
//            // placeholder for drawing integration
//            displayImage = state.baseImage
//
//        default:
//            displayImage = state.baseImage
//        }
//    }
//}



import SwiftUI
import Combine
import PencilKit

final class EditorViewModel: ObservableObject {

    @Published private(set) var displayImage: UIImage?
    @Published private(set) var canUndo = false
    @Published private(set) var canRedo = false

    let toolsViewModel = ToolsViewModel()
    let filterVM: FilterViewModel

    private let history: CommandHistoryService
    private var cancellables = Set<AnyCancellable>()

    init() {
        history = CommandHistoryService(initialState: EditorState())
        filterVM = FilterViewModel(history: history)
        setupBindings()
    }
    
    // MARK: - Public API

    func loadImage(_ image: UIImage) {
        let newState = EditorState(baseImage: image)
        history.reset(to: newState)
    }
    

    func perform(_ command: EditorCommand) {
        history.perform(command)
    }
    
    func undo() { history.undo() }
    func redo() { history.redo() }
    
    // MARK: - Display Computation
    private func updateDisplay(state: EditorState,
                               tool: ToolsViewModel.ToolMode) {
        guard let base = state.baseImage else {
                 displayImage = nil
                 return
             }
        switch tool {
        case .filter:
            displayImage = filterVM.applyFiltersChain(state.filters, to: base)
        case .draw:
            displayImage = state.baseImage
        default:
            displayImage = state.baseImage
        }
    }
}

private extension EditorViewModel {
    // MARK: - Bindings Setup
    func setupBindings() {
        bindHistoryFlags()
        bindToolActions()
        bindToolSwitchCommit()
        bindDisplayLogic()
    }

    func bindHistoryFlags() {
          history.$canUndo
            .receive(on: DispatchQueue.main)
              .assign(to: \ .canUndo, on: self)
              .store(in: &cancellables)
          history.$canRedo
            .receive(on: DispatchQueue.main)
              .assign(to: \ .canRedo, on: self)
              .store(in: &cancellables)

          history.$canUndo
            .receive(on: DispatchQueue.main)
              .assign(to: \ .canUndo, on: toolsViewModel)
              .store(in: &cancellables)
          history.$canRedo
            .receive(on: DispatchQueue.main)
              .assign(to: \ .canRedo, on: toolsViewModel)
              .store(in: &cancellables)
      }
    
    func bindToolActions() {
       toolsViewModel.undoTapped
           .sink { [weak self] in self?.undo() }
           .store(in: &cancellables)
       toolsViewModel.redoTapped
           .sink { [weak self] in self?.redo() }
           .store(in: &cancellables)
   }
    
    func bindToolSwitchCommit() {
           toolsViewModel.$currentTool
               .pairwise()
               .sink { [weak self] previous, current in
                   guard let self = self else { return }
                   if previous == .filter && current != .filter {
                    
                   }
               }
               .store(in: &cancellables)
       }
    
    func bindDisplayLogic() {
        Publishers.CombineLatest(
            history.$state,
            toolsViewModel.$currentTool
        )
        .sink { [weak self] state, tool in
            self?.updateDisplay(state: state, tool: tool)
        }
        .store(in: &cancellables)
    }

}

 
// MARK: - Combine Helper

extension Publisher {
    /// Emit pairwise elements (previous, current)
    func pairwise() -> AnyPublisher<(Output, Output), Failure> {
        self
            .scan([]) { acc, value in
                Array((acc + [value]).suffix(2))
            }
            .compactMap { pair -> (Output, Output)? in
                guard pair.count == 2 else { return nil }
                return (pair[0], pair[1])
            }
            .eraseToAnyPublisher()
    }
}
