import XCTest
@testable import Thmanyah_Assignment

final class FetchHomeSectionsUseCaseTests: XCTestCase {

    private var mockRepository: MockHomeRepository!
    private var sut: FetchHomeSectionsUseCase!

    override func setUp() {
        super.setUp()
        mockRepository = MockHomeRepository()
        sut = FetchHomeSectionsUseCase(repository: mockRepository)
    }

    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }

    func test_execute_delegatesToRepositoryWithCorrectPage() async throws {
        let (sections, pagination) = TestFixtures.makeSectionsPage1()
        mockRepository.result = .success((sections, pagination))

        let (result, _) = try await sut.execute(page: 3)

        XCTAssertEqual(mockRepository.fetchCallCount, 1)
        XCTAssertEqual(mockRepository.lastRequestedPage, 3)
        XCTAssertEqual(result.count, sections.count)
    }

    func test_execute_returnsSectionsFromRepository() async throws {
        let expected = [
            TestFixtures.makeSection(id: "1-0", title: "Section A"),
            TestFixtures.makeSection(id: "1-1", title: "Section B")
        ]
        let pagination = TestFixtures.makePagination(totalPages: 1)
        mockRepository.result = .success((expected, pagination))

        let (sections, pag) = try await sut.execute(page: 1)

        XCTAssertEqual(sections.count, 2)
        XCTAssertEqual(sections[0].title, "Section A")
        XCTAssertEqual(sections[1].title, "Section B")
        XCTAssertEqual(pag.totalPages, 1)
        XCTAssertNil(pag.nextPage)
    }

    func test_execute_whenRepositoryThrows_propagatesError() async {
        mockRepository.result = .failure(AppError.networkFailure)

        do {
            _ = try await sut.execute(page: 1)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(error as? AppError, .networkFailure)
        }
    }

    func test_execute_whenRepositoryThrowsDecodingError_propagates() async {
        mockRepository.result = .failure(AppError.decodingFailure)

        do {
            _ = try await sut.execute(page: 1)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(error as? AppError, .decodingFailure)
        }
    }
}
