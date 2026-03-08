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
            mapSection(section, feedIndex: offset + index)
        }
    }

    private func mapSection(_ section: Section, feedIndex: Int) -> ContentSectionDisplayModel {
        let sectionID = ContentSectionDisplayID(feedIndex: feedIndex)
        return ContentSectionDisplayModel(
            id: sectionID,
            sectionId: section.id,
            title: section.title,
            layoutType: resolveLayout(type: section.type, contentType: section.contentType),
            entries: section.items.enumerated().map { itemIndex, item in
                mapItem(
                    item,
                    sectionID: sectionID,
                    itemIndex: itemIndex
                )
            }
        )
    }

    private func resolveLayout(type: SectionType, contentType: ContentType?) -> DisplayLayoutType {
        switch type {
        case .queue:
            return .stackedCarousel
        case .bigSquare:
            return .bigSquare
        case .square:
            return .square
        case .twoLinesGrid:
            return contentType == .audioBook ? .horizontalCarousel : .twoRowGrid
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
                domainId: podcast.id,
                destinationType: .podcast,
                title: podcast.title,
                imageURL: podcast.imageURL,
                durationText: podcast.duration.formattedDuration,
                releaseDateText: nil,
                credit: episodesLabel,
                compactSubtitle: episodesLabel,
                description: nil
            )

        case .episode(let episode):
            let duration = episode.duration.formattedDuration
            return ContentSectionItemDisplayModel(
                id: itemID,
                domainId: episode.id,
                destinationType: .episode,
                title: episode.title,
                imageURL: episode.imageURL,
                durationText: duration,
                releaseDateText: episode.releaseDate?.relativeFormatted,
                credit: episode.podcastName,
                compactSubtitle: duration,
                description: nil
            )

        case .audioBook(let audioBook):
            let duration = audioBook.duration.formattedDuration
            return ContentSectionItemDisplayModel(
                id: itemID,
                domainId: audioBook.id,
                destinationType: .audioBook,
                title: audioBook.title,
                imageURL: audioBook.imageURL,
                durationText: duration,
                releaseDateText: audioBook.releaseDate?.relativeFormatted,
                credit: audioBook.authorName,
                compactSubtitle: duration,
                description: audioBook.description
            )

        case .audioArticle(let article):
            let duration = article.duration.formattedDuration
            return ContentSectionItemDisplayModel(
                id: itemID,
                domainId: article.id,
                destinationType: .article,
                title: article.title,
                imageURL: article.imageURL,
                durationText: duration,
                releaseDateText: article.releaseDate?.relativeFormatted,
                credit: article.authorName,
                compactSubtitle: duration,
                description: nil
            )
        }
    }
}
