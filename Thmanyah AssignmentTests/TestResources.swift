import Foundation
import XCTest
@testable import Thmanyah_Assignment

enum TestResourceError: Error {
    case fileNotFound(name: String)
    case readFailed(name: String, underlying: Error)
}

struct TestResources {

    static func loadJSON(named name: String, in testClass: AnyClass = HomeViewModelTests.self) throws -> Data {
        guard let url = Bundle(for: testClass).url(forResource: name, withExtension: "json") else {
            throw TestResourceError.fileNotFound(name: name)
        }
        do {
            return try Data(contentsOf: url)
        } catch {
            throw TestResourceError.readFailed(name: name, underlying: error)
        }
    }

    static func loadHomeSectionsResponse() throws -> Data {
        try loadJSON(named: "home_sections_response")
    }

    static func snakeCaseDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
