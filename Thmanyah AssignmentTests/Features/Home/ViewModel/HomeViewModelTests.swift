import XCTest
@testable import Thmanyah_Assignment

@MainActor
final class HomeViewModelTests: XCTestCase {

    private var mockUseCase: MockFetchHomeSectionsUseCase!
    private var sut: HomeViewModel!

    override func setUp() {
        super.setUp()
        mockUseCase = MockFetchHomeSectionsUseCase()
        let container = MockHomeDIContainer(useCase: mockUseCase)
        sut = HomeViewModel(container: container)
    }

    override func tearDown() {
        sut = nil
        mockUseCase = nil
        super.tearDown()
    }

    // MARK: - Initial Load Success

    func test_loadSections_givenSuccessResponse_setsLoadedStateWithSections() async {
        let (sections, pagination) = TestFixtures.makeSectionsPage1()
        mockUseCase.result = .success((sections, pagination))

        await sut.loadSections()

        guard case .loaded(let loaded) = sut.state else {
            return XCTFail("Expected .loaded, got \(sut.state)")
        }
        XCTAssertEqual(loaded.count, 2)
        XCTAssertEqual(sut.filteredSections.count, 2)
        XCTAssertTrue(sut.hasMorePages)
        XCTAssertEqual(sut.currentPage, 1)
    }

    // MARK: - Initial Load Failure

    func test_loadSections_givenNetworkFailure_setsFailedState() async {
        mockUseCase.result = .failure(AppError.networkFailure)

        await sut.loadSections()

        guard case .failed(let error) = sut.state else {
            return XCTFail("Expected .failed, got \(sut.state)")
        }
        XCTAssertEqual(error as? AppError, .networkFailure)
        XCTAssertFalse(sut.hasMorePages)
    }

    func test_loadSections_givenDecodingFailure_setsFailedState() async {
        mockUseCase.result = .failure(AppError.decodingFailure)

        await sut.loadSections()

        guard case .failed(let error) = sut.state else {
            return XCTFail("Expected .failed, got \(sut.state)")
        }
        XCTAssertEqual(error as? AppError, .decodingFailure)
    }

    // MARK: - Empty Response

    func test_loadSections_givenEmptyResponse_setsLoadedWithEmptySections() async {
        mockUseCase.result = .success(([], TestFixtures.makePagination()))

        await sut.loadSections()

        guard case .loaded(let loaded) = sut.state else {
            return XCTFail("Expected .loaded, got \(sut.state)")
        }
        XCTAssertTrue(loaded.isEmpty)
        XCTAssertTrue(sut.filteredSections.isEmpty)
        XCTAssertFalse(sut.hasMorePages)
    }

    // MARK: - Pagination

    func test_loadNextPage_givenPage1Loaded_appendsSectionsAndAdvancesPage() async {
        let (page1, pag1) = TestFixtures.makeSectionsPage1()
        let (page2, pag2) = TestFixtures.makeSectionsPage2()
        mockUseCase.resultsByPage = [
            1: .success((page1, pag1)),
            2: .success((page2, pag2))
        ]

        await sut.loadSections()

        guard case .loaded(let afterPage1) = sut.state else {
            return XCTFail("Expected .loaded after page 1")
        }
        XCTAssertEqual(afterPage1.count, 2)
        XCTAssertTrue(sut.hasMorePages)

        await sut.loadNextPageIfNeeded()

        guard case .loaded(let afterPage2) = sut.state else {
            return XCTFail("Expected .loaded after page 2")
        }
        XCTAssertEqual(afterPage2.count, 3)
        XCTAssertEqual(sut.currentPage, 2)
        XCTAssertFalse(sut.hasMorePages)
    }

    func test_loadNextPage_givenNoMorePages_doesNotFetch() async {
        mockUseCase.result = .success((
            [TestFixtures.makeSection()],
            TestFixtures.makePagination(totalPages: 1, nextPage: nil)
        ))
        await sut.loadSections()
        let callCountAfterLoad = mockUseCase.executeCallCount

        await sut.loadNextPageIfNeeded()

        XCTAssertEqual(mockUseCase.executeCallCount, callCountAfterLoad)
    }

    func test_loadNextPage_givenStateIsIdle_doesNotFetch() async {
        let initialCount = mockUseCase.executeCallCount

        await sut.loadNextPageIfNeeded()

        XCTAssertEqual(mockUseCase.executeCallCount, initialCount)
    }

    func test_loadNextPage_givenPageError_setsAlertErrorWithoutChangingState() async {
        let (page1, pag1) = TestFixtures.makeSectionsPage1()
        mockUseCase.resultsByPage = [
            1: .success((page1, pag1)),
            2: .failure(AppError.networkFailure)
        ]
        await sut.loadSections()
        let sectionsAfterPage1: [Section]
        if case .loaded(let s) = sut.state { sectionsAfterPage1 = s } else { return XCTFail("Expected .loaded") }

        await sut.loadNextPageIfNeeded()

        guard case .loaded(let afterError) = sut.state else {
            return XCTFail("State should remain .loaded after pagination error")
        }
        XCTAssertEqual(afterError.count, sectionsAfterPage1.count)
        XCTAssertNotNil(sut.alertError)
        XCTAssertEqual(sut.alertError as? AppError, .networkFailure)
    }

    // MARK: - Filter

    func test_selectedFilter_givenMixedContent_filtersPodcastsOnly() async {
        let mixed = TestFixtures.makeMixedContentSections()
        mockUseCase.result = .success((mixed, TestFixtures.makePagination()))
        await sut.loadSections()
        XCTAssertEqual(sut.filteredSections.count, 3)

        sut.selectedFilter = .podcast

        XCTAssertEqual(sut.filteredSections.count, 1)
        XCTAssertEqual(sut.filteredSections.first?.title, "Podcasts")
    }

    func test_selectedFilter_givenMixedContent_filtersAudioArticlesOnly() async {
        let mixed = TestFixtures.makeMixedContentSections()
        mockUseCase.result = .success((mixed, TestFixtures.makePagination()))
        await sut.loadSections()

        sut.selectedFilter = .audioArticle

        XCTAssertEqual(sut.filteredSections.count, 1)
        XCTAssertEqual(sut.filteredSections.first?.title, "Articles")
    }

    func test_selectedFilter_givenMixedContent_filtersAudioBooksOnly() async {
        let mixed = TestFixtures.makeMixedContentSections()
        mockUseCase.result = .success((mixed, TestFixtures.makePagination()))
        await sut.loadSections()

        sut.selectedFilter = .audioBook

        XCTAssertEqual(sut.filteredSections.count, 1)
        XCTAssertEqual(sut.filteredSections.first?.title, "Books")
    }

    func test_selectedFilter_switchBackToAll_showsAllSections() async {
        let mixed = TestFixtures.makeMixedContentSections()
        mockUseCase.result = .success((mixed, TestFixtures.makePagination()))
        await sut.loadSections()
        sut.selectedFilter = .podcast
        XCTAssertEqual(sut.filteredSections.count, 1)

        sut.selectedFilter = .all

        XCTAssertEqual(sut.filteredSections.count, 3)
    }

    func test_selectedFilter_givenNoMatchingContent_returnsEmpty() async {
        let podcastOnly = [TestFixtures.makeSection(
            id: "1-0", title: "Pods", contentType: .podcast, order: 0
        )]
        mockUseCase.result = .success((podcastOnly, TestFixtures.makePagination()))
        await sut.loadSections()

        sut.selectedFilter = .audioBook

        XCTAssertTrue(sut.filteredSections.isEmpty)
    }

    // MARK: - Retry

    func test_retry_givenFailedThenSuccess_recoversToLoadedState() async {
        mockUseCase.result = .failure(AppError.networkFailure)
        await sut.loadSections()
        guard case .failed = sut.state else {
            return XCTFail("Expected .failed state first")
        }

        let (sections, pagination) = TestFixtures.makeSectionsPage1()
        mockUseCase.result = .success((sections, pagination))
        await sut.retry()

        guard case .loaded(let loaded) = sut.state else {
            return XCTFail("Expected .loaded after retry, got \(sut.state)")
        }
        XCTAssertEqual(loaded.count, 2)
    }

    // MARK: - Reload Clears Previous Data

    func test_loadSections_givenPreviouslyLoaded_resetsToNewData() async {
        let (page1, pag1) = TestFixtures.makeSectionsPage1()
        mockUseCase.result = .success((page1, pag1))
        await sut.loadSections()

        let singleSection = [TestFixtures.makeSection(id: "new-1", title: "Fresh")]
        mockUseCase.result = .success((singleSection, TestFixtures.makePagination()))
        await sut.loadSections()

        guard case .loaded(let loaded) = sut.state else {
            return XCTFail("Expected .loaded")
        }
        XCTAssertEqual(loaded.count, 1)
        XCTAssertEqual(loaded.first?.title, "Fresh")
        XCTAssertEqual(sut.currentPage, 1)
    }
}
