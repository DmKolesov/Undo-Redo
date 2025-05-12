//
//  SelectImageView.swift
//  UndoRedoEditor
//
//  Created by Dima Kolesov on 12.05.2025.
//

import Foundation
import SwiftUI

struct SelectImageView: View {
    var onTap: () -> Void

    var body: some View {
        VStack {
            Button(action: onTap) {
                VStack(spacing: 16) {
                    Image(systemName: "photo.on.rectangle.angled")
                        .font(.system(size: 48))
                        .foregroundColor(.secondary)
                    Text("Выберите изображение")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
                .background(Color(.systemBackground))
            }
            .accessibilityLabel("Кнопка выбора изображения")
        }
    }
}
struct SelectImageView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer {
            SelectImageView {
                
            }
        }
    }
}
