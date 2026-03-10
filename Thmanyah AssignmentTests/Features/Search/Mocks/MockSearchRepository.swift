@testable import Thmanyah_Assignment

final class MockSearchRepository: SearchRepositoryProtocol {
    var result: Result<[ContentItem], Error> = .success([])
    private(set) var searchCallCount = 0
    private(set) var lastQuery: String?

    func search(query: String) async throws -> [ContentItem] {
        searchCallCount += 1
        lastQuery = query
        return try result.get()
    }
}
