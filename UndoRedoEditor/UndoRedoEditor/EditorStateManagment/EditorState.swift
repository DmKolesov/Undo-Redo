//
//  EditorState.swift
//  UndoRedoEditor
//
//  Created by Dima Kolesov on 12.05.2025.
//

import Foundation
import SwiftUI
import PencilKit

struct EditorState {
    var baseImage: UIImage? = nil
    var drawning: PKDrawing = PKDrawing()
    var filters: [FilterItem] = []
    //var textOverlays: [TextOverlay] = []
}

protocol EditorCommand: AnyObject {
    var id: UUID { get }
    func execute(on state: inout EditorState)
    func undo(on state: inout EditorState)
}



final class DrawStrokeCommand: EditorCommand {
    
    let id: UUID = UUID()
    private let stroke: PKStroke
    
    init(stroke: PKStroke) {
        self.stroke = stroke
    }
    
    func execute(on state: inout EditorState) {
        state.drawning.strokes.append(stroke)
    }
    
    func undo(on state: inout EditorState) {
        _ = state.drawning.strokes.popLast()
    }
}

final class ApplyFilterCommand: EditorCommand {
    let id: UUID = UUID()
    private let filter: FilterItem
    
    init(filter: FilterItem) {
        self.filter = filter
    }
    
    func execute(on state: inout EditorState) {
        state.filters.append(filter)
    }
    
    func undo(on state: inout EditorState) {
        _ = state.filters.popLast()
    }
}

final class CommandHistoryService: ObservableObject {
    @Published private(set) var canUndo = false
    @Published private(set) var canRedo = false
    @Published private(set) var state: EditorState

    private var undoStack: [EditorCommand] = []
    private var redoStack: [EditorCommand] = []

    init(initialState: EditorState) {
        self.state = initialState
        updateFlags()
    }

    func perform(_ command: EditorCommand) {
        command.execute(on: &state)
        undoStack.append(command)
        redoStack.removeAll()
        updateFlags()
    }

    func undo() {
        guard let cmd = undoStack.popLast() else { return }
        cmd.undo(on: &state)
        redoStack.append(cmd)
        updateFlags()
    }

    func redo() {
        guard let cmd = redoStack.popLast() else { return }
        cmd.execute(on: &state)
        undoStack.append(cmd)
        updateFlags()
    }

    private func updateFlags() {
        canUndo = !undoStack.isEmpty
        canRedo = !redoStack.isEmpty
    }
}
extension CommandHistoryService {

   func clearHistory() {
        undoStack.removeAll()
        redoStack.removeAll()
        updateFlags()
    }
    
    func reset(to newState: EditorState) {
          undoStack.removeAll()
          redoStack.removeAll()
          state = newState
          updateFlags()
      }
}

