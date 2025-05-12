//
//  FilterView.swift
//  UndoRedoEditor
//
//  Created by Dima Kolesov on 12.05.2025.
//

import Foundation
import SwiftUI

struct FilterView: View {
    @ObservedObject var viewModel: FilterViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(FilterItem.allCases.filter { $0 != .none }) { filter in
                    Button(action: { viewModel.apply(filter: filter, on: viewModel.baseImage ?? UIImage()) }) {
                        HStack(spacing: 8) {
                            if let icon = filter.iconName {
                                Image(systemName: icon)
                            }
                            Text(filter.displayName)
                        }
                    }
                    .buttonStyle(FilterButtonModifier(isActive: true))
                    .transition(.scale.combined(with: .opacity))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .background(Color(.systemGroupedBackground))
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer {
        FilterView(viewModel: FilterViewModel())
        }
    }
}
