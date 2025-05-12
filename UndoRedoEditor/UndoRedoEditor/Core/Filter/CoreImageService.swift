//
//  CoreImageService.swift
//  UndoRedoEditor
//
//  Created by Dima Kolesov on 12.05.2025.
//

import Foundation
import SwiftUI
import CoreImage

final class CoreImageService {
    private let context: CIContext

    init(context: CIContext = CIContext(options: [.useSoftwareRenderer: false])) {
        self.context = context
    }

    func applyFilter(_ filter: FilterItem, to image: UIImage) -> UIImage? {

        guard let ciImage = CIImage(image: image) else { return nil }
        guard let ciFilter = filter.createCIFilter() else { return nil }
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)

        guard let outputCIImage = ciFilter.outputImage else { return nil }

        let extent = outputCIImage.extent
        guard let cgImage = context.createCGImage(outputCIImage, from: extent) else { return nil }

        return UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
    }
}
