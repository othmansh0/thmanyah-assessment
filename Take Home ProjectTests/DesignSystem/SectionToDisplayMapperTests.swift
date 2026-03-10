import XCTest
@testable import Take_Home_Project

final class SectionToDisplayMapperTests: XCTestCase {

    private let sut = SectionToDisplayMapper()

    // MARK: - Layout Resolution

    func test_map_givenQueueType_resolvesToStackedCarousel() {
        let section = TestFixtures.makeSection(type: .queue, contentType: .podcast)

        let result = sut.map([section], startingAt: 0)

        XCTAssertEqual(result.first?.layoutType, .stackedCarousel)
    }

    func test_map_givenBigSquareType_resolvesToBigSquare() {
        let section = TestFixtures.makeSection(type: .bigSquare, contentType: .podcast)

        let result = sut.map([section], startingAt: 0)

        XCTAssertEqual(result.first?.layoutType, .bigSquare)
    }

    func test_map_givenSquareType_resolvesToSquare() {
        let section = TestFixtures.makeSection(type: .square, contentType: .podcast)

        let result = sut.map([section], startingAt: 0)

        XCTAssertEqual(result.first?.layoutType, .square)
    }

    func test_map_givenTwoLinesGridWithAudioBook_resolvesToHorizontalCarousel() {
        let section = TestFixtures.makeSection(
            type: .twoLinesGrid, contentType: .audioBook,
            items: [.audioBook(TestFixtures.makeAudioBook())]
        )

        let result = sut.map([section], startingAt: 0)

        XCTAssertEqual(result.first?.layoutType, .horizontalCarousel)
    }

    func test_map_givenTwoLinesGridWithEpisode_resolvesToTwoRowGrid() {
        let section = TestFixtures.makeSection(
            type: .twoLinesGrid, contentType: .episode,
            items: [.episode(TestFixtures.makeEpisode())]
        )

        let result = sut.map([section], startingAt: 0)

        XCTAssertEqual(result.first?.layoutType, .twoRowGrid)
    }

    func test_map_givenTwoLinesGridWithNilContentType_resolvesToTwoRowGrid() {
        let section = TestFixtures.makeSection(
            type: .twoLinesGrid, contentType: nil,
            items: [.podcast(TestFixtures.makePodcast())]
        )

        let result = sut.map([section], startingAt: 0)

        XCTAssertEqual(result.first?.layoutType, .twoRowGrid)
    }

    // MARK: - Section Mapping

    func test_map_setsSectionIdFromDomain() {
        let section = TestFixtures.makeSection(id: "1-5", title: "My Section")

        let result = sut.map([section], startingAt: 0)

        XCTAssertEqual(result.first?.sectionId, "1-5")
        XCTAssertEqual(result.first?.title, "My Section")
    }

    func test_map_setsIdFromFeedIndex() {
        let sections = [
            TestFixtures.makeSection(id: "1-0", order: 0),
            TestFixtures.makeSection(id: "1-1", order: 1)
        ]

        let result = sut.map(sections, startingAt: 3)

        XCTAssertEqual(result[0].id.feedIndex, 3)
        XCTAssertEqual(result[1].id.feedIndex, 4)
    }

    func test_map_mapsAllItemsInSection() {
        let section = TestFixtures.makeSection(
            items: [
                .podcast(TestFixtures.makePodcast(id: "p1")),
                .podcast(TestFixtures.makePodcast(id: "p2")),
                .podcast(TestFixtures.makePodcast(id: "p3"))
            ]
        )

        let result = sut.map([section], startingAt: 0)

        XCTAssertEqual(result.first?.entries.count, 3)
    }

    // MARK: - Item Mapping Per Content Type

    func test_mapItem_givenPodcast_setsDestinationTypePodcast() {
        let podcast = TestFixtures.makePodcast(id: "pod1", title: "Pod Title")
        let sectionID = ContentSectionDisplayID(feedIndex: 0)

        let result = sut.mapItem(.podcast(podcast), sectionID: sectionID, itemIndex: 0)

        XCTAssertEqual(result.domainId, "pod1")
        XCTAssertEqual(result.destinationType, .podcast)
        XCTAssertEqual(result.title, "Pod Title")
    }

    func test_mapItem_givenEpisode_setsDestinationTypeEpisode() {
        let episode = TestFixtures.makeEpisode(id: "ep1", title: "Ep Title", podcastName: "Source Pod")
        let sectionID = ContentSectionDisplayID(feedIndex: 0)

        let result = sut.mapItem(.episode(episode), sectionID: sectionID, itemIndex: 0)

        XCTAssertEqual(result.domainId, "ep1")
        XCTAssertEqual(result.destinationType, .episode)
        XCTAssertEqual(result.title, "Ep Title")
        XCTAssertEqual(result.credit, "Source Pod")
    }

    func test_mapItem_givenAudioBook_setsDestinationTypeAudioBook() {
        let book = TestFixtures.makeAudioBook(id: "ab1", title: "Book Title", authorName: "Author")
        let sectionID = ContentSectionDisplayID(feedIndex: 0)

        let result = sut.mapItem(.audioBook(book), sectionID: sectionID, itemIndex: 0)

        XCTAssertEqual(result.domainId, "ab1")
        XCTAssertEqual(result.destinationType, .audioBook)
        XCTAssertEqual(result.credit, "Author")
    }

    func test_mapItem_givenAudioArticle_setsDestinationTypeArticle() {
        let article = TestFixtures.makeAudioArticle(id: "art1", title: "Art Title", authorName: "Writer")
        let sectionID = ContentSectionDisplayID(feedIndex: 0)

        let result = sut.mapItem(.audioArticle(article), sectionID: sectionID, itemIndex: 0)

        XCTAssertEqual(result.domainId, "art1")
        XCTAssertEqual(result.destinationType, .article)
        XCTAssertEqual(result.credit, "Writer")
    }

    // MARK: - Item ID

    func test_mapItem_setsCorrectItemID() {
        let sectionID = ContentSectionDisplayID(feedIndex: 2)

        let result = sut.mapItem(.podcast(TestFixtures.makePodcast()), sectionID: sectionID, itemIndex: 5)

        XCTAssertEqual(result.id.sectionID, sectionID)
        XCTAssertEqual(result.id.itemIndex, 5)
    }
}
