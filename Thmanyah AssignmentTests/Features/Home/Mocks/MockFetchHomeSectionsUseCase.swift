@testable import Thmanyah_Assignment

final class MockFetchHomeSectionsUseCase: FetchHomeSectionsUseCaseProtocol {
    var result: Result<([Section], Pagination), Error> = .success(([], Pagination(totalPages: 1, nextPage: nil)))
    var resultsByPage: [Int: Result<([Section], Pagination), Error>] = [:]
    private(set) var executeCallCount = 0
    private(set) var lastRequestedPage: Int?

    func execute(page: Int) async throws -> ([Section], Pagination) {
        executeCallCount += 1
        lastRequestedPage = page

        if let pageResult = resultsByPage[page] {
            return try pageResult.get()
        }
        return try result.get()
    }
}
