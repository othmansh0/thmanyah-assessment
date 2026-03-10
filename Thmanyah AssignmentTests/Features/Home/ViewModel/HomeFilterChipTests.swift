import XCTest
@testable import Thmanyah_Assignment

final class HomeFilterChipTests: XCTestCase {

    func test_contentType_givenAll_returnsNil() {
        XCTAssertNil(HomeFilterChip.all.contentType)
    }

    func test_contentType_givenPodcast_returnsPodcast() {
        XCTAssertEqual(HomeFilterChip.podcast.contentType, .podcast)
    }

    func test_contentType_givenAudioArticle_returnsAudioArticle() {
        XCTAssertEqual(HomeFilterChip.audioArticle.contentType, .audioArticle)
    }

    func test_contentType_givenAudioBook_returnsAudioBook() {
        XCTAssertEqual(HomeFilterChip.audioBook.contentType, .audioBook)
    }

    func test_localizedTitle_allCases_returnNonEmptyString() {
        for chip in HomeFilterChip.allCases {
            XCTAssertFalse(chip.localizedTitle.isEmpty, "\(chip) has empty localizedTitle")
        }
    }

    func test_allCases_containsFourValues() {
        XCTAssertEqual(HomeFilterChip.allCases.count, 4)
    }
}
