//
//  SectionToDisplayMapper.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import Foundation

struct SectionToDisplayMapper {
    func map(
        _ sections: [Section],
        startingAt offset: Int
    ) -> [ContentSectionDisplayModel] {
        sections.enumerated().map { index, section in
            let sectionID = ContentSectionDisplayID(feedIndex: offset + index)
            return ContentSectionDisplayModel(
                id: sectionID,
                title: section.title,
                type: section.type,
                contentType: section.contentType,
                entries: section.items.enumerated().map { itemIndex, item in
                    mapItem(
                        item,
                        sectionID: sectionID,
                        itemIndex: itemIndex
                    )
                }
            )
        }
    }

    private func mapItem(
        _ item: ContentItem,
        sectionID: ContentSectionDisplayID,
        itemIndex: Int
    ) -> ContentSectionItemDisplayModel {
        let itemID = ContentSectionItemDisplayID(
            sectionID: sectionID,
            itemIndex: itemIndex
        )

        switch item {
        case .podcast(let podcast):
            let episodesLabel = String(
                format: String(localized: "episodes_count"),
                locale: Locale.currentWithWesternNumerals,
                podcast.episodeCount
            )
            return ContentSectionItemDisplayModel(
                id: itemID,
                title: podcast.title,
                imageURL: podcast.imageURL,
                durationText: podcast.duration.formattedDuration,
                releaseDateText: nil,
                credit: episodesLabel,
                compactSubtitle: episodesLabel
            )

        case .episode(let episode):
            let duration = episode.duration.formattedDuration
            return ContentSectionItemDisplayModel(
                id: itemID,
                title: episode.title,
                imageURL: episode.imageURL,
                durationText: duration,
                releaseDateText: episode.releaseDate?.relativeFormatted,
                credit: episode.podcastName,
                compactSubtitle: duration
            )

        case .audioBook(let audioBook):
            let duration = audioBook.duration.formattedDuration
            return ContentSectionItemDisplayModel(
                id: itemID,
                title: audioBook.title,
                imageURL: audioBook.imageURL,
                durationText: duration,
                releaseDateText: audioBook.releaseDate?.relativeFormatted,
                credit: audioBook.authorName,
                compactSubtitle: duration
            )

        case .audioArticle(let article):
            let duration = article.duration.formattedDuration
            return ContentSectionItemDisplayModel(
                id: itemID,
                title: article.title,
                imageURL: article.imageURL,
                durationText: duration,
                releaseDateText: article.releaseDate?.relativeFormatted,
                credit: article.authorName,
                compactSubtitle: duration
            )
        }
    }
}
