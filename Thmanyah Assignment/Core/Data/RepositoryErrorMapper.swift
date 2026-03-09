//
//  RepositoryErrorMapper.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 09/03/2026.
//

import Foundation

/// Maps a raw networking or decoding error to an `AppError`.
/// Used by all repository implementations to ensure consistent error surfacing.
func mapToAppError(_ error: Error) -> AppError {
    if let appError = error as? AppError {
        return appError
    }

    if let networkError = error as? NetworkError {
        switch networkError {
        case .networkFailure, .invalidURL, .noData:
            return .networkFailure
        case .decodingFailed:
            return .decodingFailure
        case .serverError:
            return .unknown
        }
    }

    if error is DecodingError {
        return .decodingFailure
    }

    return .unknown
}
