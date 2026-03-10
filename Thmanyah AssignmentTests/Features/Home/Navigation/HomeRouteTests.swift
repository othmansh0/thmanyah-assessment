import XCTest
@testable import Thmanyah_Assignment

final class HomeRouteTests: XCTestCase {

    func test_from_givenPodcastDestination_returnsPodcastDetail() {
        let entry = makeEntry(destinationType: .podcast, domainId: "pod-123")

        let route = HomeRoute.from(entry)

        XCTAssertEqual(route, .podcastDetail(id: "pod-123"))
    }

    func test_from_givenEpisodeDestination_returnsEpisodeDetail() {
        let entry = makeEntry(destinationType: .episode, domainId: "ep-456")

        let route = HomeRoute.from(entry)

        XCTAssertEqual(route, .episodeDetail(id: "ep-456"))
    }

    func test_from_givenAudioBookDestination_returnsAudioBookDetail() {
        let entry = makeEntry(destinationType: .audioBook, domainId: "ab-789")

        let route = HomeRoute.from(entry)

        XCTAssertEqual(route, .audioBookDetail(id: "ab-789"))
    }

    func test_from_givenArticleDestination_returnsAudioArticleDetail() {
        let entry = makeEntry(destinationType: .article, domainId: "art-012")

        let route = HomeRoute.from(entry)

        XCTAssertEqual(route, .audioArticleDetail(id: "art-012"))
    }

    // MARK: - Helpers

    private func makeEntry(
        destinationType: DestinationType,
        domainId: String
    ) -> ContentSectionItemDisplayModel {
        ContentSectionItemDisplayModel(
            id: ContentSectionItemDisplayID(
                sectionID: ContentSectionDisplayID(feedIndex: 0),
                itemIndex: 0
            ),
            domainId: domainId,
            destinationType: destinationType,
            title: "Title",
            imageURL: nil,
            durationText: "",
            releaseDateText: nil,
            credit: "",
            compactSubtitle: "",
            description: nil
        )
    }
}
