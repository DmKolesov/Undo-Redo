//
//  ToolsbarView.swift
//  UndoRedoEditor
//
//  Created by Dima Kolesov on 12.05.2025.
//

import SwiftUI

struct ToolsView: View {
    @ObservedObject var viewModel: ToolsViewModel
    let onDone: () -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {

                Button(action: {
                    print("Готово нажато")
                    onDone()
                }) {
                    Text("Готово")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(viewModel.canUndo ? .blue : .gray)
                        .padding(.horizontal, 12)
                        .contentShape(Rectangle())
                }
                .disabled(!viewModel.canUndo)

                Button(action: {
                    print(" Undo нажато")
                    viewModel.undo()
                }) {
                    Image(systemName: "arrow.uturn.backward")
                }
                .buttonStyle(ToolbarButtonStateModifier(isActive: viewModel.canUndo))
                .disabled(!viewModel.canUndo)

                Button(action: {
                    print("↪️ Redo нажато")
                    viewModel.redo()
                }) {
                    Image(systemName: "arrow.uturn.forward")
                }
                .buttonStyle(ToolbarButtonStateModifier(isActive: viewModel.canRedo))
                .disabled(!viewModel.canRedo)

                Button {
                    print(" Draw tool tapped")
                    viewModel.toggle(tool: .draw)
                } label: {
                    Image(systemName: "pencil.tip")
                }
                .buttonStyle(ToolbarButtonModifier(isActive: viewModel.currentTool == .draw))

                Button {
                    print("🎨 Filter tool tapped")
                    viewModel.toggle(tool: .filter)
                } label: {
                    Image(systemName: "camera.filters")
                }
                .buttonStyle(ToolbarButtonModifier(isActive: viewModel.currentTool == .filter))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .background(Color(.systemGray6))
    }
}

struct ToolsView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer {
            ToolsView(viewModel: ToolsViewModel(), onDone: {})
        }
    }
}

