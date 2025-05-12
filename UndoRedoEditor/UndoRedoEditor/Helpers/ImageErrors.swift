//
//  ImageErrors.swift
//  UndoRedoEditor
//
//  Created by Dima Kolesov on 12.05.2025.
//

import Foundation

enum ImageError: LocalizedError, Equatable {
    
    case saveFailed(message: String)
    
    case filterPaletteFailed
    
    case imageProcessingFailed
    
    case noPermission
    
    case sourceUnavailable
    
    case imageConversionFailed
    
    case unknownError
    
    var errorDescription: String? {
        
        switch self {
        case .saveFailed(let message): return "Ошибка сохранения: \(message)"
        case .filterPaletteFailed: return "Ошибка применения фильтра"
        case .imageProcessingFailed: return "Ошибка обработки изображения"
        case .noPermission: return "Необходим доступ для продолжения"
        case .sourceUnavailable: return "Источник недоступен"
        case .imageConversionFailed: return "Ошибка обработки изображения"
        case .unknownError: return "Неизвестная ошибка"
            
        }
    }
}
