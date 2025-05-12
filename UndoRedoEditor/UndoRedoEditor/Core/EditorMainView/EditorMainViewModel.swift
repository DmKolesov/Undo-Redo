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

final class EditorViewModel: ObservableObject {
    @Published private(set) var state: EditorState
    @Published private(set) var canUndo: Bool = false
    @Published private(set) var canRedo: Bool = false

    private let history: CommandHistoryService
    private var cancellables = Set<AnyCancellable>()


    let filterVM: FilterViewModel

    init(initialImage: UIImage) {
        let initialState = EditorState(baseImage: initialImage, drawning: PKDrawing(), filters: .init())
        history = CommandHistoryService(initialState: initialState)
        state = initialState

        filterVM = FilterViewModel(history: history)

        history.$state
            .sink { [weak self] newState in
                self?.state = newState
            }
            .store(in: &cancellables)

        history.$canUndo
            .assign(to: \ .canUndo, on: self)
            .store(in: &cancellables)

        history.$canRedo
            .assign(to: \ .canRedo, on: self)
            .store(in: &cancellables)
    }

    func perform(_ command: EditorCommand) {
        history.perform(command)
    }

    func undo() {
        history.undo()
    }

    func redo() {
        history.redo()
    }
}
