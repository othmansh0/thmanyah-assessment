//
//  DTOMappers.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import Foundation

private let iso8601Formatter: ISO8601DateFormatter = {
    let f = ISO8601DateFormatter()
    f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    return f
}()

private func parseDate(_ string: String?) -> Date? {
    guard let string else { return nil }
    return iso8601Formatter.date(from: string)
        ?? ISO8601DateFormatter().date(from: string)
}

extension SectionDTO {
    func toDomain() -> Section {
        Section(
            id: String(order),
            title: name,
            type: SectionType(apiValue: type),
            contentType: contentType.flatMap { ContentType(rawValue: $0) },
            order: order,
            items: items.map { $0.toDomain() }
        )
    }
}

extension ContentItemDTO {
    func toDomain() -> ContentItem {
        switch self {
        case .podcast(let dto):      return .podcast(dto.toDomain())
        case .episode(let dto):      return .episode(dto.toDomain())
        case .audioBook(let dto):    return .audioBook(dto.toDomain())
        case .audioArticle(let dto): return .audioArticle(dto.toDomain())
        }
    }
}

extension PodcastDTO {
    func toDomain() -> Podcast {
        Podcast(
            id: podcastId,
            title: name,
            imageURL: avatarUrl.flatMap { URL(string: $0) },
            episodeCount: episodeCount,
            duration: duration,
            language: language
        )
    }
}

extension EpisodeDTO {
    func toDomain() -> Episode {
        Episode(
            id: episodeId,
            title: name,
            imageURL: avatarUrl.flatMap { URL(string: $0) },
            duration: duration,
            audioURL: audioUrl.flatMap { URL(string: $0) },
            releaseDate: parseDate(releaseDate),
            podcastName: podcastName,
            podcastId: podcastId
        )
    }
}

extension AudioBookDTO {
    func toDomain() -> AudioBook {
        AudioBook(
            id: audiobookId,
            title: name,
            imageURL: avatarUrl.flatMap { URL(string: $0) },
            authorName: authorName,
            duration: duration,
            language: language,
            releaseDate: parseDate(releaseDate)
        )
    }
}

extension AudioArticleDTO {
    func toDomain() -> AudioArticle {
        AudioArticle(
            id: articleId,
            title: name,
            imageURL: avatarUrl.flatMap { URL(string: $0) },
            authorName: authorName,
            duration: duration,
            releaseDate: parseDate(releaseDate)
        )
    }
}

extension PaginationDTO {
    func toDomain() -> Pagination {
        Pagination(
            totalPages: totalPages,
            hasNextPage: nextPage != nil
        )
    }
}
