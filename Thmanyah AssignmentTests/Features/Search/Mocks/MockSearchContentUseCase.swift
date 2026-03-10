@testable import Thmanyah_Assignment

final class MockSearchContentUseCase: SearchContentUseCaseProtocol {
    var result: Result<[ContentItem], Error> = .success([])
    private(set) var executeCallCount = 0
    private(set) var lastQuery: String?

    func execute(query: String) async throws -> [ContentItem] {
        executeCallCount += 1
        lastQuery = query
        return try result.get()
    }
}
