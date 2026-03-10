import XCTest
@testable import Take_Home_Project

final class SearchRouteTests: XCTestCase {

    func test_from_givenPodcastDestination_returnsPodcastDetail() {
        let entry = makeEntry(destinationType: .podcast, domainId: "pod-1")

        let route = SearchRoute.from(entry)

        XCTAssertEqual(route, .podcastDetail(id: "pod-1"))
    }

    func test_from_givenEpisodeDestination_returnsEpisodeDetail() {
        let entry = makeEntry(destinationType: .episode, domainId: "ep-2")

        let route = SearchRoute.from(entry)

        XCTAssertEqual(route, .episodeDetail(id: "ep-2"))
    }

    func test_from_givenAudioBookDestination_returnsAudioBookDetail() {
        let entry = makeEntry(destinationType: .audioBook, domainId: "ab-3")

        let route = SearchRoute.from(entry)

        XCTAssertEqual(route, .audioBookDetail(id: "ab-3"))
    }

    func test_from_givenArticleDestination_returnsAudioArticleDetail() {
        let entry = makeEntry(destinationType: .article, domainId: "art-4")

        let route = SearchRoute.from(entry)

        XCTAssertEqual(route, .audioArticleDetail(id: "art-4"))
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
