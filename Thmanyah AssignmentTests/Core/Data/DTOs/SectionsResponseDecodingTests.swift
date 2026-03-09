import XCTest
@testable import Thmanyah_Assignment

final class SectionsResponseDecodingTests: XCTestCase {

    func test_decode_givenRealAPIJSON_decodesToValidSections() throws {
        let data = TestResources.loadHomeSectionsResponse()
        let decoder = TestResources.snakeCaseDecoder()

        let dto = try decoder.decode(SectionsResponseDTO.self, from: data)

        XCTAssertEqual(dto.sections.count, 7)
        XCTAssertEqual(dto.pagination.totalPages, 10)
        XCTAssertEqual(dto.pagination.nextPage, "/home_sections?page=2")
    }

    func test_decode_givenRealAPIJSON_sectionTypesAreCorrect() throws {
        let data = TestResources.loadHomeSectionsResponse()
        let decoder = TestResources.snakeCaseDecoder()
        let dto = try decoder.decode(SectionsResponseDTO.self, from: data)

        let types = dto.sections.map { $0.type }
        XCTAssertTrue(types.contains("square"))
        XCTAssertTrue(types.contains("2_lines_grid"))
        XCTAssertTrue(types.contains("big_square"))
        XCTAssertTrue(types.contains("queue"))
        XCTAssertTrue(types.contains("big square"))
    }

    func test_decode_givenRealAPIJSON_contentTypesAreCorrect() throws {
        let data = TestResources.loadHomeSectionsResponse()
        let decoder = TestResources.snakeCaseDecoder()
        let dto = try decoder.decode(SectionsResponseDTO.self, from: data)

        let contentTypes = Set(dto.sections.compactMap { $0.contentType })
        XCTAssertTrue(contentTypes.contains("podcast"))
        XCTAssertTrue(contentTypes.contains("episode"))
        XCTAssertTrue(contentTypes.contains("audio_book"))
        XCTAssertTrue(contentTypes.contains("audio_article"))
    }

    func test_decode_givenRealAPIJSON_allSectionsHaveContent() throws {
        let data = TestResources.loadHomeSectionsResponse()
        let decoder = TestResources.snakeCaseDecoder()
        let dto = try decoder.decode(SectionsResponseDTO.self, from: data)

        for section in dto.sections {
            XCTAssertFalse(section.items.isEmpty, "Section '\(section.name)' has no items")
        }
    }

    func test_decode_thenMapToDomain_producesValidSections() throws {
        let data = TestResources.loadHomeSectionsResponse()
        let decoder = TestResources.snakeCaseDecoder()
        let dto = try decoder.decode(SectionsResponseDTO.self, from: data)

        let sections = dto.sections.map { $0.toDomain(pageNumber: 1) }
        let pagination = dto.pagination.toDomain()

        XCTAssertEqual(sections.count, 7)
        XCTAssertEqual(pagination.totalPages, 10)
        XCTAssertNotNil(pagination.nextPage)

        for section in sections {
            XCTAssertFalse(section.title.isEmpty, "Section id=\(section.id) has empty title")
            XCTAssertFalse(section.items.isEmpty, "Section id=\(section.id) has no items")
            XCTAssertTrue(section.id.hasPrefix("1-"), "Section id=\(section.id) should start with page number")
        }
    }
}
