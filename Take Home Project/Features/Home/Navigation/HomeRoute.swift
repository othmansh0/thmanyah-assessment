//
//  HomeRoute.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 08/03/2026.
//

import Foundation

enum HomeRoute: Hashable {
    case podcastDetail(id: String)
    case episodeDetail(id: String)
    case audioBookDetail(id: String)
    case audioArticleDetail(id: String)
}

extension HomeRoute {
    static func from(_ entry: ContentSectionItemDisplayModel) -> HomeRoute {
        switch entry.destinationType {
        case .podcast:   return .podcastDetail(id: entry.domainId)
        case .episode:   return .episodeDetail(id: entry.domainId)
        case .audioBook: return .audioBookDetail(id: entry.domainId)
        case .article:   return .audioArticleDetail(id: entry.domainId)
        }
    }
}
