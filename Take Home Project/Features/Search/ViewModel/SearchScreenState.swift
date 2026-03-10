//
//  SearchScreenState.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 09/03/2026.
//

enum SearchScreenState: Equatable {
    case idle
    case searching
    case results([ContentSectionItemDisplayModel])
    case empty
    case failed(AppError)

    static func == (lhs: SearchScreenState, rhs: SearchScreenState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.searching, .searching), (.empty, .empty):
            return true
        case (.results(let left), .results(let right)):
            return left == right
        case (.failed(let left), .failed(let right)):
            return left == right
        default:
            return false
        }
    }
}
