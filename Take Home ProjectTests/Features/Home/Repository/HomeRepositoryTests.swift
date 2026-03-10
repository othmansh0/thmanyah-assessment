import XCTest
@testable import Take_Home_Project

final class HomeRepositoryTests: XCTestCase {

    private var mockDataSource: MockHomeDataSource!
    private var sut: HomeRepository!

    override func setUp() {
        super.setUp()
        mockDataSource = MockHomeDataSource()
        sut = HomeRepository(dataSource: mockDataSource)
    }

    override func tearDown() {
        sut = nil
        mockDataSource = nil
        super.tearDown()
    }

    func test_fetchSections_delegatesToDataSourceWithCorrectPage() async throws {
        _ = try await sut.fetchSections(page: 5)

        XCTAssertEqual(mockDataSource.fetchCallCount, 1)
        XCTAssertEqual(mockDataSource.lastRequestedPage, 5)
    }

    func test_fetchSections_givenEmptyResponse_returnsEmptySections() async throws {
        mockDataSource.result = .success(
            SectionsResponseDTO(sections: [], pagination: PaginationDTO(nextPage: nil, totalPages: 1))
        )

        let (sections, pagination) = try await sut.fetchSections(page: 1)

        XCTAssertTrue(sections.isEmpty)
        XCTAssertEqual(pagination.totalPages, 1)
        XCTAssertNil(pagination.nextPage)
    }

    func test_fetchSections_givenNetworkError_throwsNetworkFailure() async {
        mockDataSource.result = .failure(NetworkError.networkFailure(NSError(domain: "", code: -1)))

        do {
            _ = try await sut.fetchSections(page: 1)
            XCTFail("Expected error")
        } catch let error as AppError {
            XCTAssertEqual(error, .networkFailure)
        } catch {
            XCTFail("Expected AppError, got \(error)")
        }
    }

    func test_fetchSections_givenDecodingError_throwsDecodingFailure() async {
        let decodingError = DecodingError.dataCorrupted(
            .init(codingPath: [], debugDescription: "test")
        )
        mockDataSource.result = .failure(decodingError)

        do {
            _ = try await sut.fetchSections(page: 1)
            XCTFail("Expected error")
        } catch let error as AppError {
            XCTAssertEqual(error, .decodingFailure)
        } catch {
            XCTFail("Expected AppError, got \(error)")
        }
    }

    func test_fetchSections_givenServerError_throwsUnknown() async {
        mockDataSource.result = .failure(NetworkError.serverError(statusCode: 500))

        do {
            _ = try await sut.fetchSections(page: 1)
            XCTFail("Expected error")
        } catch let error as AppError {
            XCTAssertEqual(error, .unknown)
        } catch {
            XCTFail("Expected AppError, got \(error)")
        }
    }

    func test_fetchSections_givenUnknownError_throwsUnknown() async {
        mockDataSource.result = .failure(NSError(domain: "test", code: 42))

        do {
            _ = try await sut.fetchSections(page: 1)
            XCTFail("Expected error")
        } catch let error as AppError {
            XCTAssertEqual(error, .unknown)
        } catch {
            XCTFail("Expected AppError, got \(error)")
        }
    }
}
