//
//  ContentSectionItemDisplayModel+Preview.swift
//  Thmanyah Assignment
//
//  Mock data from API response for SwiftUI previews.
//

import Foundation

#if DEBUG
extension ContentSectionItemDisplayModel {
    /// Bestselling Audiobooks (big_square, audio_book) — BigSquareCardView
    static let previewAudioBook: ContentSectionItemDisplayModel = {
        let sectionID = ContentSectionDisplayID(feedIndex: 2)
        return ContentSectionItemDisplayModel(
            id: ContentSectionItemDisplayID(sectionID: sectionID, itemIndex: 0),
            title: "The Art of War",
            imageURL: URL(string: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228"),
            durationText: "10h 0m",
            releaseDateText: "Jan 10, 2023",
            credit: "Sun Tzu",
            compactSubtitle: "10h 0m"
        )
    }()

    /// Top Podcasts (square, podcast) — SquareCardView
    static let previewPodcast: ContentSectionItemDisplayModel = {
        let sectionID = ContentSectionDisplayID(feedIndex: 0)
        return ContentSectionItemDisplayModel(
            id: ContentSectionItemDisplayID(sectionID: sectionID, itemIndex: 0),
            title: "State of the World from NPR",
            imageURL: URL(string: "https://media.npr.org/assets/img/2023/10/11/stateofworld_sq-75fa8776ed49f02437f7283e25e054b9cc4db31c.jpg?s=1400&c=66&f=jpg"),
            durationText: "87h 24m",
            releaseDateText: nil,
            credit: "805 episodes",
            compactSubtitle: "805 episodes"
        )
    }()

    /// BigSquareOverlayCardView — Arabic RTL preview (من ذاكرة تاريخ العرب)
    static let previewEpisodeArabic: ContentSectionItemDisplayModel = {
        let sectionID = ContentSectionDisplayID(feedIndex: 5)
        return ContentSectionItemDisplayModel(
            id: ContentSectionItemDisplayID(sectionID: sectionID, itemIndex: 1),
            title: "من ذاكرة تاريخ العرب",
            imageURL: URL(string: "https://media.npr.org/assets/img/2023/03/01/npr-news-now_square.png?s=1400&c=66"),
            durationText: "20m",
            releaseDateText: nil,
            credit: "20 حلقة",
            compactSubtitle: "20 حلقة"
        )
    }()

    /// Editor's Pick Episodes (big_square, episode) — BigSquareOverlayCardView
    static let previewEpisode: ContentSectionItemDisplayModel = {
        let sectionID = ContentSectionDisplayID(feedIndex: 5)
        return ContentSectionItemDisplayModel(
            id: ContentSectionItemDisplayID(sectionID: sectionID, itemIndex: 0),
            title: "NPR Politics Live From Chicago",
            imageURL: URL(string: "https://media.npr.org/assets/img/2024/01/11/podcast-politics_2023_update1_sq-be7ef464dd058fe663d9e4cfe836fb9309ad0a4d.jpg?s=1400&c=66&f=jpg"),
            durationText: "23m",
            releaseDateText: "Oct 23, 2017",
            credit: "The NPR Politics Podcast",
            compactSubtitle: "23m"
        )
    }()

    /// Must-Read Audio Articles (square, audio_article) — SquareCardView
    static let previewAudioArticle: ContentSectionItemDisplayModel = {
        let sectionID = ContentSectionDisplayID(feedIndex: 3)
        return ContentSectionItemDisplayModel(
            id: ContentSectionItemDisplayID(sectionID: sectionID, itemIndex: 0),
            title: "The Future of AI",
            imageURL: URL(string: "https://bookbrush.com/wp-content/uploads/BookBrushImage-2021-5-11-20-5227-1024x1024.jpg"),
            durationText: "20m",
            releaseDateText: "May 10, 2023",
            credit: "Tech World",
            compactSubtitle: "20m"
        )
    }()

    /// Trending Episodes (2_lines_grid, episode) — QueueItemRowView
    static let previewEpisodeRow: ContentSectionItemDisplayModel = {
        let sectionID = ContentSectionDisplayID(feedIndex: 1)
        return ContentSectionItemDisplayModel(
            id: ContentSectionItemDisplayID(sectionID: sectionID, itemIndex: 0),
            title: "NPR News: 07-27-2024 2PM EDT",
            imageURL: URL(string: "https://media.npr.org/assets/img/2023/03/01/npr-news-now_square.png?s=1400&c=66"),
            durationText: "5m",
            releaseDateText: "Jul 27, 2024",
            credit: "NPR News Now",
            compactSubtitle: "5m"
        )
    }()

    /// Popular in Audiobooks (2_lines_grid, audio_book) — QueueItemRowView
    static let previewAudioBookRow: ContentSectionItemDisplayModel = {
        let sectionID = ContentSectionDisplayID(feedIndex: 6)
        return ContentSectionItemDisplayModel(
            id: ContentSectionItemDisplayID(sectionID: sectionID, itemIndex: 0),
            title: "The Art of War",
            imageURL: URL(string: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228"),
            durationText: "10h 0m",
            releaseDateText: "Jan 10, 2023",
            credit: "Sun Tzu",
            compactSubtitle: "10h 0m"
        )
    }()
}
#endif
