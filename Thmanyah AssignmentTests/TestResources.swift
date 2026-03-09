import Foundation
import XCTest
@testable import Thmanyah_Assignment

struct TestResources {

    static func loadJSON(named name: String, in testClass: AnyClass = HomeViewModelTests.self) -> Data {
        let url = Bundle(for: testClass)
            .url(forResource: name, withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static func loadHomeSectionsResponse() -> Data {
        loadJSON(named: "home_sections_response")
    }

    static func snakeCaseDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
