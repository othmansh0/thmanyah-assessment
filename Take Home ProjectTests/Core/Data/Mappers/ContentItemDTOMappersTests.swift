import XCTest
@testable import Take_Home_Project

final class ContentItemDTOMappersTests: XCTestCase {

    // MARK: - Podcast

    func test_podcastDTO_toDomain_mapsAllFields() throws {
        let json = """
        {
            "podcast_id": "pod123",
            "name": "Test Podcast",
            "avatar_url": "https://example.com/img.jpg",
            "episode_count": 42,
            "duration": 3600,
            "language": "ar"
        }
        """.data(using: .utf8)!
        let dto = try makeDecoder().decode(PodcastDTO.self, from: json)

        let domain = dto.toDomain()

        XCTAssertEqual(domain.id, "pod123")
        XCTAssertEqual(domain.title, "Test Podcast")
        XCTAssertEqual(domain.imageURL, URL(string: "https://example.com/img.jpg"))
        XCTAssertEqual(domain.episodeCount, 42)
        XCTAssertEqual(domain.duration, 3600)
        XCTAssertEqual(domain.language, "ar")
    }

    func test_podcastDTO_toDomain_givenNilOptionals_setsNil() throws {
        let json = """
        {
            "podcast_id": "pod456",
            "name": "No Extras",
            "episode_count": 0,
            "duration": 0
        }
        """.data(using: .utf8)!
        let dto = try makeDecoder().decode(PodcastDTO.self, from: json)

        let domain = dto.toDomain()

        XCTAssertNil(domain.imageURL)
        XCTAssertNil(domain.language)
    }

    // MARK: - Episode

    func test_episodeDTO_toDomain_mapsAllFields() throws {
        let json = """
        {
            "episode_id": "ep123",
            "name": "Test Episode",
            "avatar_url": "https://example.com/ep.jpg",
            "duration": 1800,
            "audio_url": "https://example.com/audio.mp3",
            "release_date": "2024-07-27T10:00:00.000Z",
            "podcast_name": "My Podcast",
            "podcast_id": "pod123"
        }
        """.data(using: .utf8)!
        let dto = try makeDecoder().decode(EpisodeDTO.self, from: json)

        let domain = dto.toDomain()

        XCTAssertEqual(domain.id, "ep123")
        XCTAssertEqual(domain.title, "Test Episode")
        XCTAssertEqual(domain.imageURL, URL(string: "https://example.com/ep.jpg"))
        XCTAssertEqual(domain.duration, 1800)
        XCTAssertEqual(domain.audioURL, URL(string: "https://example.com/audio.mp3"))
        XCTAssertNotNil(domain.releaseDate)
        XCTAssertEqual(domain.podcastName, "My Podcast")
        XCTAssertEqual(domain.podcastId, "pod123")
    }

    func test_episodeDTO_toDomain_givenNilReleaseDate_setsNil() throws {
        let json = """
        {
            "episode_id": "ep456",
            "name": "No Date",
            "duration": 600,
            "podcast_name": "Podcast",
            "podcast_id": "pod1"
        }
        """.data(using: .utf8)!
        let dto = try makeDecoder().decode(EpisodeDTO.self, from: json)

        let domain = dto.toDomain()

        XCTAssertNil(domain.releaseDate)
        XCTAssertNil(domain.audioURL)
    }

    // MARK: - AudioBook

    func test_audioBookDTO_toDomain_mapsAllFields() throws {
        let json = """
        {
            "audiobook_id": "ab123",
            "name": "Test Book",
            "avatar_url": "https://example.com/book.jpg",
            "author_name": "Author",
            "description": "A book",
            "duration": 7200,
            "language": "en",
            "release_date": "2023-01-10T08:00:00Z"
        }
        """.data(using: .utf8)!
        let dto = try makeDecoder().decode(AudioBookDTO.self, from: json)

        let domain = dto.toDomain()

        XCTAssertEqual(domain.id, "ab123")
        XCTAssertEqual(domain.title, "Test Book")
        XCTAssertEqual(domain.imageURL, URL(string: "https://example.com/book.jpg"))
        XCTAssertEqual(domain.authorName, "Author")
        XCTAssertEqual(domain.description, "A book")
        XCTAssertEqual(domain.duration, 7200)
        XCTAssertEqual(domain.language, "en")
        XCTAssertNotNil(domain.releaseDate)
    }

    func test_audioBookDTO_toDomain_givenNilOptionals_setsNil() throws {
        let json = """
        {
            "audiobook_id": "ab456",
            "name": "Minimal",
            "author_name": "Nobody",
            "duration": 0
        }
        """.data(using: .utf8)!
        let dto = try makeDecoder().decode(AudioBookDTO.self, from: json)

        let domain = dto.toDomain()

        XCTAssertNil(domain.imageURL)
        XCTAssertNil(domain.language)
        XCTAssertNil(domain.releaseDate)
        XCTAssertNil(domain.description)
    }

    // MARK: - AudioArticle

    func test_audioArticleDTO_toDomain_mapsAllFields() throws {
        let json = """
        {
            "article_id": "art123",
            "name": "Test Article",
            "avatar_url": "https://example.com/art.jpg",
            "author_name": "Writer",
            "duration": 900,
            "release_date": "2023-05-10T10:00:00Z"
        }
        """.data(using: .utf8)!
        let dto = try makeDecoder().decode(AudioArticleDTO.self, from: json)

        let domain = dto.toDomain()

        XCTAssertEqual(domain.id, "art123")
        XCTAssertEqual(domain.title, "Test Article")
        XCTAssertEqual(domain.imageURL, URL(string: "https://example.com/art.jpg"))
        XCTAssertEqual(domain.authorName, "Writer")
        XCTAssertEqual(domain.duration, 900)
        XCTAssertNotNil(domain.releaseDate)
    }

    func test_audioArticleDTO_toDomain_givenNilOptionals_setsNil() throws {
        let json = """
        {
            "article_id": "art456",
            "name": "Minimal",
            "author_name": "None",
            "duration": 0
        }
        """.data(using: .utf8)!
        let dto = try makeDecoder().decode(AudioArticleDTO.self, from: json)

        let domain = dto.toDomain()

        XCTAssertNil(domain.imageURL)
        XCTAssertNil(domain.releaseDate)
    }

    // MARK: - ContentItemDTO Dispatch

    func test_contentItemDTO_podcast_toDomain_returnsPodcastCase() throws {
        let json = """
        {
            "podcast_id": "p1",
            "name": "P",
            "episode_count": 1,
            "duration": 100
        }
        """.data(using: .utf8)!
        let podcastDTO = try makeDecoder().decode(PodcastDTO.self, from: json)
        let itemDTO = ContentItemDTO.podcast(podcastDTO)

        let domain = itemDTO.toDomain()

        if case .podcast(let p) = domain {
            XCTAssertEqual(p.id, "p1")
        } else {
            XCTFail("Expected .podcast, got \(domain)")
        }
    }

    func test_contentItemDTO_episode_toDomain_returnsEpisodeCase() throws {
        let json = """
        {
            "episode_id": "e1",
            "name": "E",
            "duration": 200,
            "podcast_name": "P",
            "podcast_id": "p1"
        }
        """.data(using: .utf8)!
        let episodeDTO = try makeDecoder().decode(EpisodeDTO.self, from: json)
        let itemDTO = ContentItemDTO.episode(episodeDTO)

        let domain = itemDTO.toDomain()

        if case .episode(let e) = domain {
            XCTAssertEqual(e.id, "e1")
        } else {
            XCTFail("Expected .episode, got \(domain)")
        }
    }

    // MARK: - Helpers

    private func makeDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
