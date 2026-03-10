import Foundation
@testable import Thmanyah_Assignment

struct TestFixtures {

    // MARK: - Domain Models

    static func makePodcast(
        id: String = "podcast-1",
        title: String = "Test Podcast",
        episodeCount: Int = 10,
        duration: Int = 3600
    ) -> Podcast {
        Podcast(
            id: id,
            title: title,
            imageURL: URL(string: "https://example.com/podcast.jpg"),
            episodeCount: episodeCount,
            duration: duration,
            language: "ar"
        )
    }

    static func makeEpisode(
        id: String = "episode-1",
        title: String = "Test Episode",
        duration: Int = 1800,
        podcastName: String = "Test Podcast",
        podcastId: String = "podcast-1"
    ) -> Episode {
        Episode(
            id: id,
            title: title,
            imageURL: URL(string: "https://example.com/episode.jpg"),
            duration: duration,
            audioURL: URL(string: "https://example.com/audio.mp3"),
            releaseDate: Date(timeIntervalSince1970: 1_700_000_000),
            podcastName: podcastName,
            podcastId: podcastId
        )
    }

    static func makeAudioBook(
        id: String = "audiobook-1",
        title: String = "Test AudioBook",
        authorName: String = "Author Name",
        duration: Int = 7200
    ) -> AudioBook {
        AudioBook(
            id: id,
            title: title,
            imageURL: URL(string: "https://example.com/book.jpg"),
            authorName: authorName,
            description: "A test audiobook",
            duration: duration,
            language: "ar",
            releaseDate: Date(timeIntervalSince1970: 1_700_000_000)
        )
    }

    static func makeAudioArticle(
        id: String = "article-1",
        title: String = "Test Article",
        authorName: String = "Author Name",
        duration: Int = 900
    ) -> AudioArticle {
        AudioArticle(
            id: id,
            title: title,
            imageURL: URL(string: "https://example.com/article.jpg"),
            authorName: authorName,
            duration: duration,
            releaseDate: Date(timeIntervalSince1970: 1_700_000_000)
        )
    }

    static func makeSection(
        id: String = "1-0",
        title: String = "Test Section",
        type: SectionType = .bigSquare,
        contentType: ContentType? = .podcast,
        order: Int = 0,
        items: [ContentItem]? = nil
    ) -> Section {
        Section(
            id: id,
            title: title,
            type: type,
            contentType: contentType,
            order: order,
            items: items ?? [.podcast(makePodcast())]
        )
    }

    static func makePagination(
        totalPages: Int = 1,
        nextPage: Int? = nil
    ) -> Pagination {
        Pagination(totalPages: totalPages, nextPage: nextPage)
    }

    // MARK: - Multi-page Scenarios

    static func makeSectionsPage1() -> ([Section], Pagination) {
        let sections = [
            makeSection(
                id: "1-0", title: "Podcasts", type: .bigSquare,
                contentType: .podcast, order: 0,
                items: [
                    .podcast(makePodcast(id: "p1", title: "Podcast 1")),
                    .podcast(makePodcast(id: "p2", title: "Podcast 2"))
                ]
            ),
            makeSection(
                id: "1-1", title: "Episodes", type: .twoLinesGrid,
                contentType: .episode, order: 1,
                items: [
                    .episode(makeEpisode(id: "e1", title: "Episode 1")),
                    .episode(makeEpisode(id: "e2", title: "Episode 2"))
                ]
            )
        ]
        return (sections, makePagination(totalPages: 2, nextPage: 2))
    }

    static func makeSectionsPage2() -> ([Section], Pagination) {
        let sections = [
            makeSection(
                id: "2-0", title: "Audio Books", type: .twoLinesGrid,
                contentType: .audioBook, order: 0,
                items: [.audioBook(makeAudioBook(id: "ab1", title: "Book 1"))]
            )
        ]
        return (sections, makePagination(totalPages: 2, nextPage: nil))
    }

    static func makeMixedContentSections() -> [Section] {
        [
            makeSection(
                id: "1-0", title: "Podcasts", type: .bigSquare,
                contentType: .podcast, order: 0,
                items: [.podcast(makePodcast())]
            ),
            makeSection(
                id: "1-1", title: "Articles", type: .twoLinesGrid,
                contentType: .audioArticle, order: 1,
                items: [.audioArticle(makeAudioArticle())]
            ),
            makeSection(
                id: "1-2", title: "Books", type: .twoLinesGrid,
                contentType: .audioBook, order: 2,
                items: [.audioBook(makeAudioBook())]
            )
        ]
    }

    // MARK: - Search Results

    static func makeSearchResults() -> [ContentItem] {
        [
            .podcast(makePodcast(id: "sp1", title: "Search Podcast")),
            .episode(makeEpisode(id: "se1", title: "Search Episode")),
            .audioArticle(makeAudioArticle(id: "sa1", title: "Search Article"))
        ]
    }
}
