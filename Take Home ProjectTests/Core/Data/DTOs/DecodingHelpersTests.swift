import XCTest
@testable import Take_Home_Project

final class DecodingHelpersTests: XCTestCase {

    func test_decodeIntOrString_givenIntValue_returnsInt() throws {
        let json = """
        {"value": 42}
        """.data(using: .utf8)!

        let result = try JSONDecoder().decode(TestWrapper.self, from: json)

        XCTAssertEqual(result.value, 42)
    }

    func test_decodeIntOrString_givenNumericString_parsesToInt() throws {
        let json = """
        {"value": "123"}
        """.data(using: .utf8)!

        let result = try JSONDecoder().decode(TestWrapper.self, from: json)

        XCTAssertEqual(result.value, 123)
    }

    func test_decodeIntOrString_givenNonNumericString_returnsZero() throws {
        let json = """
        {"value": "not-a-number"}
        """.data(using: .utf8)!

        let result = try JSONDecoder().decode(TestWrapper.self, from: json)

        XCTAssertEqual(result.value, 0)
    }

    func test_decodeIntOrString_givenEmptyString_returnsZero() throws {
        let json = """
        {"value": ""}
        """.data(using: .utf8)!

        let result = try JSONDecoder().decode(TestWrapper.self, from: json)

        XCTAssertEqual(result.value, 0)
    }

    func test_decodeIntOrString_givenZeroInt_returnsZero() throws {
        let json = """
        {"value": 0}
        """.data(using: .utf8)!

        let result = try JSONDecoder().decode(TestWrapper.self, from: json)

        XCTAssertEqual(result.value, 0)
    }

    func test_decodeIntOrString_givenNegativeInt_returnsNegative() throws {
        let json = """
        {"value": -5}
        """.data(using: .utf8)!

        let result = try JSONDecoder().decode(TestWrapper.self, from: json)

        XCTAssertEqual(result.value, -5)
    }
}

private struct TestWrapper: Decodable {
    let value: Int

    enum CodingKeys: CodingKey {
        case value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try container.decodeIntOrString(forKey: .value)
    }
}
