import XCTest
@testable import Thmanyah_Assignment

final class SearchRepositoryTests: XCTestCase {

    private var mockDataSource: MockSearchDataSource!
    private var sut: SearchRepository!

    override func setUp() {
        super.setUp()
        mockDataSource = MockSearchDataSource()
        sut = SearchRepository(dataSource: mockDataSource)
    }

    override func tearDown() {
        sut = nil
        mockDataSource = nil
        super.tearDown()
    }

    func test_search_delegatesToDataSourceWithCorrectQuery() async throws {
        _ = try await sut.search(query: "swift")

        XCTAssertEqual(mockDataSource.searchCallCount, 1)
        XCTAssertEqual(mockDataSource.lastQuery, "swift")
    }

    func test_search_givenEmptyResults_returnsEmptyArray() async throws {
        mockDataSource.result = .success([])

        let results = try await sut.search(query: "nothing")

        XCTAssertTrue(results.isEmpty)
    }

    func test_search_givenNetworkError_throwsNetworkFailure() async {
        mockDataSource.result = .failure(NetworkError.networkFailure(NSError(domain: "", code: -1)))

        do {
            _ = try await sut.search(query: "test")
            XCTFail("Expected error")
        } catch let error as AppError {
            XCTAssertEqual(error, .networkFailure)
        } catch {
            XCTFail("Expected AppError, got \(error)")
        }
    }

    func test_search_givenServerError_throwsUnknown() async {
        mockDataSource.result = .failure(NetworkError.serverError(statusCode: 503))

        do {
            _ = try await sut.search(query: "test")
            XCTFail("Expected error")
        } catch let error as AppError {
            XCTAssertEqual(error, .unknown)
        } catch {
            XCTFail("Expected AppError, got \(error)")
        }
    }
}
