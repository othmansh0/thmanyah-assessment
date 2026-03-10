import XCTest
@testable import Take_Home_Project

final class SearchContentUseCaseTests: XCTestCase {

    private var mockRepository: MockSearchRepository!
    private var sut: SearchContentUseCase!

    override func setUp() {
        super.setUp()
        mockRepository = MockSearchRepository()
        sut = SearchContentUseCase(repository: mockRepository)
    }

    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }

    func test_execute_delegatesToRepositoryWithCorrectQuery() async throws {
        mockRepository.result = .success([])

        _ = try await sut.execute(query: "swift")

        XCTAssertEqual(mockRepository.searchCallCount, 1)
        XCTAssertEqual(mockRepository.lastQuery, "swift")
    }

    func test_execute_returnsItemsFromRepository() async throws {
        let expected = TestFixtures.makeSearchResults()
        mockRepository.result = .success(expected)

        let results = try await sut.execute(query: "test")

        XCTAssertEqual(results.count, expected.count)
    }

    func test_execute_whenRepositoryThrows_propagatesError() async {
        mockRepository.result = .failure(AppError.networkFailure)

        do {
            _ = try await sut.execute(query: "fail")
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(error as? AppError, .networkFailure)
        }
    }

    // UseCase passes through all queries; the ViewModel prevents empty queries from reaching it.
    func test_execute_withEmptyQuery_stillDelegatesToRepository() async throws {
        mockRepository.result = .success([])

        _ = try await sut.execute(query: "")

        XCTAssertEqual(mockRepository.searchCallCount, 1)
        XCTAssertEqual(mockRepository.lastQuery, "")
    }
}
