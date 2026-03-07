//
//  AppError.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import Foundation

enum AppError: LocalizedError {
    case networkFailure
    case decodingFailure
    case unknown

    var errorDescription: String? {
        switch self {
        case .networkFailure:
            return String(localized: "app_error_network_failure")
        case .decodingFailure:
            return String(localized: "app_error_decoding_failure")
        case .unknown:
            return String(localized: "app_error_unknown")
        }
    }

    var recoverySuggestion: String? {
        String(localized: "app_error_recovery_suggestion")
    }
}
