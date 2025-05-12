//
//  DrawingTools.swift
//  UndoRedoEditor
//
//  Created by Dima Kolesov on 12.05.2025.
//

import PencilKit

enum DrawingTools: String, Identifiable, CaseIterable, Hashable {
    case pen
    case marker
    
    var id: String { rawValue }
    
    var inkType: PKInk.InkType {
        switch self {
        case .pen: return .pen
        case .marker: return .marker
        }
    }
    
    var color: UIColor {
        switch self {
        case .pen: return .black
        case .marker: return .red
        }
    }
    
    var width: CGFloat {
        switch self {
        case .pen: return 3
        case .marker: return 10
        }
    }
    
    var iconName: String {
        switch self {
        case .pen: return "pencil"
        case .marker: return "highlighter"
        }
    }
    
    var displayName: String {
        switch self {
        case .pen: return "Pen"
        case .marker: return "Marker"
        }
    }
    
    var pkTool: PKInkingTool {
        PKInkingTool(inkType, color: color, width: width)
    }
}
