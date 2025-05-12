//
//  PreviewContainer.swift
//  UndoRedoEditor
//
//  Created by Dima Kolesov on 12.05.2025.
//

import Foundation
import SwiftUI

struct PreviewContainer<Content: View>: View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        Group {
            // Базовый вариант
            content()
                .previewDisplayName("Default")
            
            // Темная тема
            content()
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
            
            // Большой шрифт
            content()
                .environment(\.sizeCategory, .accessibilityLarge)
                .previewDisplayName("Large Fonts")
            
            // Компактный интерфейс
            content()
                .environment(\.horizontalSizeClass, .compact)
                .previewDisplayName("Compact Layout")
        }
    }
}

struct PreviewModifiers: ViewModifier {
    let padding: Bool
    let background: Bool
    
    func body(content: Content) -> some View {
        Group {
            if padding {
                content.padding()
            } else {
                content
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(background ? Color(.systemBackground) : nil)
    }
}

extension View {
    func previewSetup(padding: Bool = true, background: Bool = true) -> some View {
        self.modifier(PreviewModifiers(padding: padding, background: background))
    }
}

