//
//  FilterButtonModifier.swift
//  UndoRedoEditor
//
//  Created by Dima Kolesov on 12.05.2025.
//

import Foundation
import SwiftUI

struct FilterButtonModifier: ButtonStyle {
    let isActive: Bool
    private let cornerRadius: CGFloat = 12

    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 8) {
            configuration.label
        }
        .padding(.horizontal, 16)
        .frame(height: 40)
        .background(isActive ? Color.accentColor : Color(.secondarySystemFill))
        .foregroundColor(isActive ? .white : .primary)
        .cornerRadius(cornerRadius)
        .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
        .animation(.interactiveSpring(), value: configuration.isPressed)
    }
}
