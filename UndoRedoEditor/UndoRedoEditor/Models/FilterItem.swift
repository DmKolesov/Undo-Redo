//
//  FilterItem.swift
//  UndoRedoEditor
//
//  Created by Dima Kolesov on 12.05.2025.
//

import Foundation
import CoreImage

enum FilterItem: Identifiable, CaseIterable {
    case none
    case sepia(intensity: Double = 1.0)
    case blackAndWhite
    case vignette(intensity: Double = 0.9, radius: Double = 1.0)
    case sharpen(sharpness: Double = 0.4)

    static var allCases: [FilterItem] {
        [
            .none,
            .sepia(),
            .blackAndWhite,
            .vignette(),
            .sharpen()
        ]
    }

    var id: String {
        switch self {
        case .none: return "none"
        case .sepia: return "sepia"
        case .blackAndWhite: return "bw"
        case .vignette: return "vignette"
        case .sharpen: return "sharpen"
        }
    }
    
    var iconName: String? {
          switch self {
          case .sepia: return "camera.filters"
          case .blackAndWhite: return "circle.lefthalf.filled"
          case .vignette: return "sun.max"
          case .sharpen: return "wand.and.stars"
          case .none: return nil
          }
      }

    var displayName: String {
        switch self {
        case .none: return "Original"
        case .sepia: return "Sepia Tone"
        case .blackAndWhite: return "Black & White"
        case .vignette: return "Vignette Effect"
        case .sharpen: return "Sharpening"
        }
    }

    func createCIFilter() -> CIFilter? {
        let filter: CIFilter?
        
        switch self {
        case .none:
            filter = nil
        case .sepia(let intensity):
            filter = CIFilter(name: "CISepiaTone")
            filter?.setValue(intensity.clamped(to: 0...1), forKey: kCIInputIntensityKey)
        case .blackAndWhite:
            filter = CIFilter(name: "CIColorControls")
            filter?.setValue(0.0, forKey: kCIInputSaturationKey)
        case .vignette(let intensity, let radius):
            filter = CIFilter(name: "CIVignette")
            filter?.setValue(intensity.clamped(to: 0...1), forKey: kCIInputIntensityKey)
            filter?.setValue(radius.clamped(to: 0...2), forKey: kCIInputRadiusKey)
        case .sharpen(let sharpness):
            filter = CIFilter(name: "CISharpenLuminance")
            filter?.setValue(sharpness.clamped(to: 0...2), forKey: kCIInputSharpnessKey)
        }
        
        if self != .none {
            assert(filter != nil, "Failed to create CIFilter for \(self.id)")
        }
        return filter
    }
}

extension FilterItem: Equatable {
    static func == (lhs: FilterItem, rhs: FilterItem) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none):
            return true
        case let (.sepia(lIntensity), .sepia(rIntensity)):
            return lIntensity == rIntensity
        case (.blackAndWhite, .blackAndWhite):
            return true
        case let (.vignette(lIntensity, lRadius), .vignette(rIntensity, rRadius)):
            return lIntensity == rIntensity && lRadius == rRadius
        case let (.sharpen(lSharpness), .sharpen(rSharpness)):
            return lSharpness == rSharpness
        default:
            return false
        }
    }
}

private extension Double {
    func clamped(to range: ClosedRange<Double>) -> Double {
        return min(max(self, range.lowerBound), range.upperBound)
    }
}
