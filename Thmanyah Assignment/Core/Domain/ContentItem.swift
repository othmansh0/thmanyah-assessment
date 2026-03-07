//
//  ContentItem.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import Foundation

enum ContentItem: Identifiable, Equatable {
    case podcast(Podcast)
    case episode(Episode)
    case audioBook(AudioBook)
    case audioArticle(AudioArticle)

    var id: String {
        switch self {
        case .podcast(let podcast): return podcast.id
        case .episode(let episode): return episode.id
        case .audioBook(let audioBook): return audioBook.id
        case .audioArticle(let audioArticle): return audioArticle.id
        }
    }
}

struct Podcast: Identifiable, Equatable {
    let id: String
    let title: String
    let imageURL: URL?
    let episodeCount: Int
    let duration: Int
    let language: String?
}

struct Episode: Identifiable, Equatable {
    let id: String
    let title: String
    let imageURL: URL?
    let duration: Int
    let audioURL: URL?
    let releaseDate: Date?
    let podcastName: String
    let podcastId: String
}

struct AudioBook: Identifiable, Equatable {
    let id: String
    let title: String
    let imageURL: URL?
    let authorName: String
    let duration: Int
    let language: String?
    let releaseDate: Date?
}

struct AudioArticle: Identifiable, Equatable {
    let id: String
    let title: String
    let imageURL: URL?
    let authorName: String
    let duration: Int
    let releaseDate: Date?
}
