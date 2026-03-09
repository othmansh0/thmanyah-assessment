@testable import Thmanyah_Assignment

final class MockHomeDataSource: HomeDataSourceProtocol {
    var result: Result<SectionsResponseDTO, Error>
    private(set) var fetchCallCount = 0
    private(set) var lastRequestedPage: Int?

    init(result: Result<SectionsResponseDTO, Error> = .success(
        SectionsResponseDTO(sections: [], pagination: PaginationDTO(nextPage: nil, totalPages: 1))
    )) {
        self.result = result
    }

    func fetchSections(page: Int) async throws -> SectionsResponseDTO {
        fetchCallCount += 1
        lastRequestedPage = page
        return try result.get()
    }
}
