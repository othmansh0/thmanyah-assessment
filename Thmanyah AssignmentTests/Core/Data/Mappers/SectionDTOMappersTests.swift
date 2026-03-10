import XCTest
@testable import Thmanyah_Assignment

final class SectionDTOMappersTests: XCTestCase {

    func test_toDomain_synthesizesIdFromPageAndOrder() {
        let dto = SectionDTO(
            name: "Test", type: "square",
            contentType: "podcast", order: 3, items: []
        )

        let section = dto.toDomain(pageNumber: 2)

        XCTAssertEqual(section.id, "2-3")
    }

    func test_toDomain_mapsNameToTitle() {
        let dto = SectionDTO(
            name: "بودكاست", type: "big_square",
            contentType: "podcast", order: 0, items: []
        )

        let section = dto.toDomain(pageNumber: 1)

        XCTAssertEqual(section.title, "بودكاست")
    }

    func test_toDomain_mapsSectionType() {
        let cases: [(String, SectionType)] = [
            ("queue", .queue),
            ("big_square", .bigSquare),
            ("big square", .bigSquare),
            ("square", .square),
            ("2_lines_grid", .twoLinesGrid),
        ]

        for (apiValue, expected) in cases {
            let dto = SectionDTO(
                name: "Test", type: apiValue,
                contentType: nil, order: 0, items: []
            )
            let section = dto.toDomain(pageNumber: 1)
            XCTAssertEqual(section.type, expected, "Failed for API value: \(apiValue)")
        }
    }

    func test_toDomain_mapsContentType() {
        let cases: [(String?, ContentType?)] = [
            ("podcast", .podcast),
            ("episode", .episode),
            ("audio_article", .audioArticle),
            ("audio_book", .audioBook),
            (nil, nil),
            ("unknown_type", nil),
        ]

        for (raw, expected) in cases {
            let dto = SectionDTO(
                name: "Test", type: "square",
                contentType: raw, order: 0, items: []
            )
            let section = dto.toDomain(pageNumber: 1)
            XCTAssertEqual(section.contentType, expected, "Failed for raw: \(String(describing: raw))")
        }
    }

    func test_toDomain_mapsOrder() {
        let dto = SectionDTO(
            name: "Test", type: "square",
            contentType: nil, order: 7, items: []
        )

        let section = dto.toDomain(pageNumber: 1)

        XCTAssertEqual(section.order, 7)
    }

    func test_toDomain_givenUnknownSectionType_defaultsToSquare() {
        let dto = SectionDTO(
            name: "Test", type: "completely_unknown",
            contentType: nil, order: 0, items: []
        )

        let section = dto.toDomain(pageNumber: 1)

        XCTAssertEqual(section.type, .square)
    }
}
