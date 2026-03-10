import XCTest
@testable import Thmanyah_Assignment

final class IntDurationTests: XCTestCase {

    func test_formattedDuration_givenZero_returnsNonEmpty() {
        let result = 0.formattedDuration
        XCTAssertFalse(result.isEmpty)
    }

    func test_formattedDuration_givenOneHour_containsHourComponent() {
        let result = 3600.formattedDuration
        XCTAssertFalse(result.isEmpty)
    }

    func test_formattedDuration_givenMinutesOnly_returnsNonEmpty() {
        let result = 1800.formattedDuration
        XCTAssertFalse(result.isEmpty)
    }

    func test_formattedDuration_givenLargeValue_returnsNonEmpty() {
        let result = 360_000.formattedDuration
        XCTAssertFalse(result.isEmpty)
    }

    func test_formattedDuration_givenSmallValue_returnsNonEmpty() {
        let result = 60.formattedDuration
        XCTAssertFalse(result.isEmpty)
    }
}
