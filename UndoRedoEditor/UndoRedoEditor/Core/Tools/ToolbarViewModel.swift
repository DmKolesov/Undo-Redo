//
//  ToolbarViewModel.swift
//  UndoRedoEditor
//
//  Created by Dima Kolesov on 12.05.2025.
//

import Foundation
import Combine

final class ToolsViewModel: ObservableObject {
    
    enum ToolMode { case none, draw, filter }

    @Published var currentTool: ToolMode = .none {
        didSet {
            showDrawingTools = (currentTool == .draw)
            showFilterTools = (currentTool == .filter)
            print("Current tool: \(currentTool)")
        }
    }
    
    @Published var showDrawingTools = false
    @Published var showFilterTools = false

    @Published var canUndo = false
    @Published var canRedo = false

    let undoTapped = PassthroughSubject<Void, Never>()
    let redoTapped = PassthroughSubject<Void, Never>()

    func undo() { undoTapped.send() }
    func redo() { redoTapped.send() }

    func toggle(tool: ToolMode) {
         currentTool = (currentTool == tool) ? .none : tool
         showDrawingTools = (currentTool == .draw)
         showFilterTools      = (currentTool == .filter)
 
         print("ToolsViewModel.toggle -> currentTool=\(currentTool), showDrawingTools=\(showDrawingTools), showFilters=\(showFilterTools)")
     }
}
