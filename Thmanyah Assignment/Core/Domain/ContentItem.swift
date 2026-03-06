//
//  ContentItem.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import Foundation

enum ContentItem: Identifiable {
    case podcast(Podcast)
    case episode(Episode)
    case audioBook(AudioBook)
    case audioArticle(AudioArticle)

    var id: String {
        switch self {
        case .podcast(let p): return p.id
        case .episode(let e): return e.id
        case .audioBook(let b): return b.id
        case .audioArticle(let a): return a.id
        }
    }
}

struct Podcast: Identifiable {
    let id: String
    let title: String
    let imageURL: URL?
    let episodeCount: Int
    let duration: Int
    let language: String?
}

struct Episode: Identifiable {
    let id: String
    let title: String
    let imageURL: URL?
    let duration: Int
    let audioURL: URL?
    let releaseDate: Date?
    let podcastName: String
    let podcastId: String
}

struct AudioBook: Identifiable {
    let id: String
    let title: String
    let imageURL: URL?
    let authorName: String
    let duration: Int
    let language: String?
    let releaseDate: Date?
}

struct AudioArticle: Identifiable {
    let id: String
    let title: String
    let imageURL: URL?
    let authorName: String
    let duration: Int
    let releaseDate: Date?
}
