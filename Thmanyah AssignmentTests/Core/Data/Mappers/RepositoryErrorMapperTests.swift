import XCTest
@testable import Thmanyah_Assignment

final class RepositoryErrorMapperTests: XCTestCase {

    // MARK: - AppError Passthrough

    func test_mapToAppError_givenAppError_returnsSameAppError() {
        XCTAssertEqual(mapToAppError(AppError.networkFailure), .networkFailure)
        XCTAssertEqual(mapToAppError(AppError.decodingFailure), .decodingFailure)
        XCTAssertEqual(mapToAppError(AppError.unknown), .unknown)
    }

    // MARK: - NetworkError Mapping

    func test_mapToAppError_givenNetworkFailure_returnsNetworkFailure() {
        let error = NetworkError.networkFailure(NSError(domain: "", code: -1))
        XCTAssertEqual(mapToAppError(error), .networkFailure)
    }

    func test_mapToAppError_givenInvalidURL_returnsNetworkFailure() {
        let error = NetworkError.invalidURL
        XCTAssertEqual(mapToAppError(error), .networkFailure)
    }

    func test_mapToAppError_givenNoData_returnsNetworkFailure() {
        let error = NetworkError.noData
        XCTAssertEqual(mapToAppError(error), .networkFailure)
    }

    func test_mapToAppError_givenDecodingFailed_returnsDecodingFailure() {
        let underlying = NSError(domain: "", code: 0)
        let error = NetworkError.decodingFailed(underlying)
        XCTAssertEqual(mapToAppError(error), .decodingFailure)
    }

    func test_mapToAppError_givenServerError_returnsUnknown() {
        let error = NetworkError.serverError(statusCode: 500)
        XCTAssertEqual(mapToAppError(error), .unknown)
    }

    // MARK: - DecodingError Mapping

    func test_mapToAppError_givenDecodingError_returnsDecodingFailure() {
        let error = DecodingError.dataCorrupted(
            .init(codingPath: [], debugDescription: "test")
        )
        XCTAssertEqual(mapToAppError(error), .decodingFailure)
    }

    // MARK: - Unknown Error

    func test_mapToAppError_givenUnknownNSError_returnsUnknown() {
        let error = NSError(domain: "com.test", code: 42)
        XCTAssertEqual(mapToAppError(error), .unknown)
    }
}
