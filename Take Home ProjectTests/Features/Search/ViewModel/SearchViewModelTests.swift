import XCTest
@testable import Take_Home_Project

@MainActor
final class SearchViewModelTests: XCTestCase {

    private var mockUseCase: MockSearchContentUseCase!
    private var sut: SearchViewModel!

    override func setUp() {
        super.setUp()
        mockUseCase = MockSearchContentUseCase()
        let container = MockSearchDIContainer(useCase: mockUseCase)
        sut = SearchViewModel(container: container, debounceNanoseconds: 1_000_000)
    }

    override func tearDown() {
        sut = nil
        mockUseCase = nil
        super.tearDown()
    }

    /// Waits for search debounce (1ms in tests) + async scheduling buffer.
    private func waitForSearchToExecute() async {
        try? await Task.sleep(nanoseconds: 50_000_000)
    }

    // MARK: - Empty Query

    func test_query_givenEmpty_stateRemainsIdle() {
        sut.query = ""

        XCTAssertEqual(sut.state, .idle)
        XCTAssertEqual(mockUseCase.executeCallCount, 0)
    }

    func test_query_givenWhitespaceOnly_stateRemainsIdle() {
        sut.query = "   "

        XCTAssertEqual(sut.state, .idle)
        XCTAssertEqual(mockUseCase.executeCallCount, 0)
    }

    func test_query_givenPreviousResults_whenCleared_resetsToIdle() async {
        mockUseCase.result = .success(TestFixtures.makeSearchResults())
        sut.query = "test"
        await waitForSearchToExecute()

        sut.query = ""

        XCTAssertEqual(sut.state, .idle)
    }

    // MARK: - Search Success

    func test_query_givenValid_whenDebounceExpires_executesSearch() async {
        let items = TestFixtures.makeSearchResults()
        mockUseCase.result = .success(items)

        sut.query = "podcast"
        await waitForSearchToExecute()

        if case .results(let displayItems) = sut.state {
            XCTAssertEqual(displayItems.count, 3)
        } else {
            XCTFail("Expected .results, got \(sut.state)")
        }
        XCTAssertEqual(mockUseCase.executeCallCount, 1)
        XCTAssertEqual(mockUseCase.lastQuery, "podcast")
    }

    // MARK: - Search Empty Results

    func test_query_givenValidWithNoResults_setsEmptyState() async {
        mockUseCase.result = .success([])

        sut.query = "nonexistent"
        await waitForSearchToExecute()

        XCTAssertEqual(sut.state, .empty)
    }

    // MARK: - Search Failure

    func test_query_givenUseCaseThrowsAppError_setsFailedState() async {
        mockUseCase.result = .failure(AppError.networkFailure)

        sut.query = "fail"
        await waitForSearchToExecute()

        XCTAssertEqual(sut.state, .failed(.networkFailure))
        XCTAssertNotNil(sut.alertError)
        XCTAssertEqual(sut.alertError as? AppError, .networkFailure)
    }

    func test_query_givenUseCaseThrowsNonAppError_setsFailedUnknown() async {
        mockUseCase.result = .failure(NSError(domain: "test", code: -1))

        sut.query = "error"
        await waitForSearchToExecute()

        XCTAssertEqual(sut.state, .failed(.unknown))
    }

    // MARK: - Deduplication

    func test_query_givenSameAsPreviousSuccess_skipsSearch() async {
        mockUseCase.result = .success([.podcast(TestFixtures.makePodcast())])
        sut.query = "podcast"
        await waitForSearchToExecute()
        XCTAssertEqual(mockUseCase.executeCallCount, 1)

        sut.query = "podcast"
        await waitForSearchToExecute()

        XCTAssertEqual(mockUseCase.executeCallCount, 1)
    }

    func test_query_givenClearedAndReentered_executesNewSearch() async {
        mockUseCase.result = .success([.podcast(TestFixtures.makePodcast())])
        sut.query = "podcast"
        await waitForSearchToExecute()
        XCTAssertEqual(mockUseCase.executeCallCount, 1)

        sut.query = ""
        sut.query = "podcast"
        await waitForSearchToExecute()

        XCTAssertEqual(mockUseCase.executeCallCount, 2)
    }

    // MARK: - Debounce Cancellation

    func test_query_givenRapidChanges_onlyLastQuerySearched() async {
        mockUseCase.result = .success([.podcast(TestFixtures.makePodcast())])

        sut.query = "a"
        sut.query = "ab"
        sut.query = "abc"
        await waitForSearchToExecute()

        XCTAssertEqual(mockUseCase.executeCallCount, 1)
        XCTAssertEqual(mockUseCase.lastQuery, "abc")
    }

    func test_query_givenChangedBeforeDebounce_cancelsPreviousTask() async {
        mockUseCase.result = .success([.podcast(TestFixtures.makePodcast())])

        sut.query = "first"
        sut.query = "second"
        await waitForSearchToExecute()

        XCTAssertEqual(mockUseCase.executeCallCount, 1)
        XCTAssertEqual(mockUseCase.lastQuery, "second")
    }

    // MARK: - Retry

    func test_retry_givenFailedState_retriggersSearch() async {
        mockUseCase.result = .failure(AppError.networkFailure)
        sut.query = "test"
        await waitForSearchToExecute()
        XCTAssertEqual(sut.state, .failed(.networkFailure))

        mockUseCase.result = .success([.podcast(TestFixtures.makePodcast())])
        sut.retry()
        await waitForSearchToExecute()

        if case .results(let items) = sut.state {
            XCTAssertEqual(items.count, 1)
        } else {
            XCTFail("Expected .results after retry, got \(sut.state)")
        }
    }

    func test_retry_clearsLastSuccessfulQuery_allowsRepeatedSearch() async {
        mockUseCase.result = .success([.podcast(TestFixtures.makePodcast())])
        sut.query = "test"
        await waitForSearchToExecute()
        XCTAssertEqual(mockUseCase.executeCallCount, 1)

        sut.retry()
        await waitForSearchToExecute()

        XCTAssertEqual(mockUseCase.executeCallCount, 2)
    }
}
