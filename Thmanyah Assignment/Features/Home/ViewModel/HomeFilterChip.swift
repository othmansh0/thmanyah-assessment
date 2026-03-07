//
//  HomeFilterChip.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import Foundation

enum HomeFilterChip: String, CaseIterable, Identifiable {
    case all
    case podcast
    case audioArticle
    case audioBook

    var id: Self { self }

    var localizedTitle: String {
        switch self {
        case .all:
            return String(localized: "filter_for_you")
        case .podcast:
            return String(localized: "filter_podcasts")
        case .audioArticle:
            return String(localized: "filter_audio_articles")
        case .audioBook:
            return String(localized: "filter_books")
        }
    }

    var contentType: ContentType? {
        switch self {
        case .all:
            return nil
        case .podcast:
            return .podcast
        case .audioArticle:
            return .audioArticle
        case .audioBook:
            return .audioBook
        }
    }
}
