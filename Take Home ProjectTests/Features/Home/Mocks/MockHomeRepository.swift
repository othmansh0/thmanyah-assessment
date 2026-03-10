@testable import Take_Home_Project

final class MockHomeRepository: HomeRepositoryProtocol {
    var result: Result<([Section], Pagination), Error> = .success(([], Pagination(totalPages: 1, nextPage: nil)))
    private(set) var fetchCallCount = 0
    private(set) var lastRequestedPage: Int?

    func fetchSections(page: Int) async throws -> ([Section], Pagination) {
        fetchCallCount += 1
        lastRequestedPage = page
        return try result.get()
    }
}
