//
//  EditorView.swift
//  UndoRedoEditor
//
//  Created by Dima Kolesov on 12.05.2025.
//

import Foundation
import SwiftUI

//struct EditorView: View {
//    @ObservedObject var viewModel: EditorViewModel
//
//    var body: some View {
//        VStack(spacing: 0) {
//            ToolsView(
//                viewModel: viewModel.toolsViewModel,
//                onDone: {
//                    print("📦 Экспорт изображения") // TODO: экспорт
//                }
//            )
//
//            GeometryReader { geo in
//                ZStack {
//                    if let image = viewModel.state?.baseImage {
//                        Image(uiImage: image)
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: geo.size.width, height: geo.size.height)
//                            .clipped()
//                    } else {
//                        Color.gray.opacity(0.1)
//                            .frame(width: geo.size.width, height: geo.size.height)
//                    }
//
//                    if viewModel.toolsViewModel.currentTool == .draw {
//                        Text("🖊 DrawingCanvas Placeholder")
//                            .frame(width: geo.size.width, height: geo.size.height)
//                    }
//                }
//            }
//
//            if viewModel.toolsViewModel.currentTool == .filter {
//              
//                if let filterVM = viewModel.filterVM {
//                    
//                    FilterView(viewModel: filterVM)
//                } else {
//                    Text("⚠️ filterVM is nil!")
//                }
//            }
//        }
//        .onAppear {
//            print("🧩 EditorView появился. Current tool: \(viewModel.toolsViewModel.currentTool)")
//        }
//    }
//}

struct EditorView: View {
    @ObservedObject var viewModel: EditorViewModel

    var body: some View {
        VStack(spacing: 0) {
            // 1) Панель глобальных инструментов
            ToolsView(
                viewModel: viewModel.toolsViewModel,
                onDone: {
                    print("📦 Экспорт: \(String(describing: viewModel.displayImage))")
                }
            )
            .padding(.vertical, 8)
            .background(Color(.systemBackground))
            .shadow(radius: 2)

            // 2) Холст с изображением + канва
            GeometryReader { geo in
                ZStack {
                    if let img = viewModel.displayImage {
                        Image(uiImage: img)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geo.size.width, height: geo.size.height)
                            .clipped()
                    } else {
                        Color.gray.opacity(0.1)
                    }
                    
                    // Если нужен DrawingCanvas, он может быть здесь:
                    if viewModel.toolsViewModel.currentTool == .draw {
//                        DrawingCanvasView(
//                            canvas: viewModel.drawingVM.canvasView,
//                            onStrokeFinished: viewModel.perform
//                        )
//                        .frame(width: geo.size.width, height: geo.size.height)
//                        .background(Color.clear)
                    }
                }
            }
            .background(Color.black.opacity(0.05))

            // 3) Нижняя панель конкретного инструмента
            Group {
                switch viewModel.toolsViewModel.currentTool {
                case .filter:
                    FilterView(viewModel: viewModel.filterVM)
                        .padding(.vertical, 8)
                        .background(Color(.secondarySystemBackground))
                        .transition(.move(edge: .bottom).combined(with: .opacity))

                case .draw:
                    // Можно вставить мини-панель настроек кисти
                    HStack {
                        Text("🖌 Brush settings")
                        Spacer()
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .transition(.move(edge: .bottom).combined(with: .opacity))

                default:
                    EmptyView()
                }
            }
            .animation(.easeInOut, value: viewModel.toolsViewModel.currentTool)
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            print("🧩 EditorView appeared, tool: \(viewModel.toolsViewModel.currentTool)")
        }
    }
}


struct EditorView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer {
            EditorView(viewModel: EditorViewModel())
        }
    }
}
