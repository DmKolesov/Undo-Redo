//
//  ToolbarButtonModifier.swift
//  UndoRedoEditor
//
//  Created by Dima Kolesov on 12.05.2025.
//

import Foundation
import SwiftUI

struct ToolbarButtonModifier: ButtonStyle {
    let isActive: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 20, weight: .medium))
            .padding(5)
            .background(
                Circle()
                    .fill(isActive ? Color.accentColor.opacity(0.2) : Color.clear)
            )
            .foregroundColor(isActive ? Color.accentColor : Color.primary)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.interactiveSpring(), value: configuration.isPressed)
    }
}

struct ToolbarButtonStateModifier: ButtonStyle {
    let isActive: Bool

    func makeBody(configuration: Configuration) -> some View {
        let fillColor = isActive ? Color.accentColor : Color.gray
        let bgColor = isActive ? Color.accentColor.opacity(0.2) : Color.clear

        return configuration.label
            .font(.system(size: 20, weight: .medium))
            .padding(5)
            .background(Circle().fill(bgColor))
            .foregroundColor(fillColor)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.interactiveSpring(), value: configuration.isPressed)
    }
}

