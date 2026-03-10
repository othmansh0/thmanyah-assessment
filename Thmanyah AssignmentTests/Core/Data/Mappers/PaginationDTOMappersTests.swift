import XCTest
@testable import Thmanyah_Assignment

final class PaginationDTOMappersTests: XCTestCase {

    func test_toDomain_givenNilNextPage_returnsNilNextPage() {
        let dto = PaginationDTO(nextPage: nil, totalPages: 3)

        let result = dto.toDomain()

        XCTAssertEqual(result.totalPages, 3)
        XCTAssertNil(result.nextPage)
    }

    func test_toDomain_givenNumericStringNextPage_parsesPageNumber() {
        let dto = PaginationDTO(nextPage: "2", totalPages: 5)

        let result = dto.toDomain()

        XCTAssertEqual(result.nextPage, 2)
        XCTAssertEqual(result.totalPages, 5)
    }

    func test_toDomain_givenURLNextPage_extractsPageQueryParam() {
        let dto = PaginationDTO(
            nextPage: "https://api.example.com/sections?page=3",
            totalPages: 5
        )

        let result = dto.toDomain()

        XCTAssertEqual(result.nextPage, 3)
    }

    func test_toDomain_givenInvalidNextPage_returnsNil() {
        let dto = PaginationDTO(nextPage: "not-a-number", totalPages: 2)

        let result = dto.toDomain()

        XCTAssertNil(result.nextPage)
    }
}
