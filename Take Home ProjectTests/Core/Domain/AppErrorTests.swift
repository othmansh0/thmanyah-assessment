import XCTest
@testable import Take_Home_Project

final class AppErrorTests: XCTestCase {

    func test_errorDescription_givenNetworkFailure_returnsNonEmpty() {
        XCTAssertNotNil(AppError.networkFailure.errorDescription)
        XCTAssertFalse(AppError.networkFailure.errorDescription!.isEmpty)
    }

    func test_errorDescription_givenDecodingFailure_returnsNonEmpty() {
        XCTAssertNotNil(AppError.decodingFailure.errorDescription)
        XCTAssertFalse(AppError.decodingFailure.errorDescription!.isEmpty)
    }

    func test_errorDescription_givenUnknown_returnsNonEmpty() {
        XCTAssertNotNil(AppError.unknown.errorDescription)
        XCTAssertFalse(AppError.unknown.errorDescription!.isEmpty)
    }

    func test_recoverySuggestion_allCases_returnNonEmpty() {
        for error in [AppError.networkFailure, .decodingFailure, .unknown] {
            XCTAssertNotNil(error.recoverySuggestion, "\(error) has nil recoverySuggestion")
            XCTAssertFalse(error.recoverySuggestion!.isEmpty, "\(error) has empty recoverySuggestion")
        }
    }

    func test_errorDescription_eachCaseIsDifferent() {
        let descriptions = [
            AppError.networkFailure.errorDescription,
            AppError.decodingFailure.errorDescription,
            AppError.unknown.errorDescription
        ]
        XCTAssertEqual(Set(descriptions).count, 3, "Each error case should have a unique description")
    }

    func test_equatable_sameCasesAreEqual() {
        XCTAssertEqual(AppError.networkFailure, AppError.networkFailure)
        XCTAssertEqual(AppError.decodingFailure, AppError.decodingFailure)
        XCTAssertEqual(AppError.unknown, AppError.unknown)
    }

    func test_equatable_differentCasesAreNotEqual() {
        XCTAssertNotEqual(AppError.networkFailure, AppError.decodingFailure)
        XCTAssertNotEqual(AppError.networkFailure, AppError.unknown)
        XCTAssertNotEqual(AppError.decodingFailure, AppError.unknown)
    }
}
