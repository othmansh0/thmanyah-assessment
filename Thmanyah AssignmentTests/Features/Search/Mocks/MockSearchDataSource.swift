@testable import Thmanyah_Assignment

final class MockSearchDataSource: SearchDataSourceProtocol {
    var result: Result<[SectionDTO], Error> = .success([])
    private(set) var searchCallCount = 0
    private(set) var lastQuery: String?

    func search(query: String) async throws -> [SectionDTO] {
        searchCallCount += 1
        lastQuery = query
        return try result.get()
    }
}
