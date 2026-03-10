import XCTest
@testable import Thmanyah_Assignment

final class EndpointTests: XCTestCase {

    // MARK: - APIHost

    func test_apiHost_sections_returnsExpectedBaseURL() {
        XCTAssertTrue(APIHost.sections.baseURL.hasPrefix("https://"))
        XCTAssertFalse(APIHost.sections.baseURL.isEmpty)
    }

    func test_apiHost_search_returnsExpectedBaseURL() {
        XCTAssertTrue(APIHost.search.baseURL.hasPrefix("https://"))
        XCTAssertFalse(APIHost.search.baseURL.isEmpty)
    }

    // MARK: - HomeEndpoint

    func test_homeEndpoint_sections_buildValidURL() {
        let endpoint = HomeEndpoint.sections(page: 1)
        let url = endpoint.url

        XCTAssertNotNil(url)
        XCTAssertTrue(url!.absoluteString.contains("/home_sections"))
        XCTAssertTrue(url!.absoluteString.contains("page=1"))
    }

    func test_homeEndpoint_sections_givenPage3_includesCorrectPageParam() {
        let endpoint = HomeEndpoint.sections(page: 3)
        let url = endpoint.url

        XCTAssertNotNil(url)
        XCTAssertTrue(url!.absoluteString.contains("page=3"))
    }

    func test_homeEndpoint_method_isGET() {
        let endpoint = HomeEndpoint.sections(page: 1)
        XCTAssertEqual(endpoint.method, .GET)
    }

    func test_homeEndpoint_host_isSections() {
        let endpoint = HomeEndpoint.sections(page: 1)
        XCTAssertEqual(endpoint.host.baseURL, APIHost.sections.baseURL)
    }

    // MARK: - SearchEndpoint

    func test_searchEndpoint_search_buildValidURL() {
        let endpoint = SearchEndpoint.search(query: "swift")
        let url = endpoint.url

        XCTAssertNotNil(url)
        XCTAssertTrue(url!.absoluteString.contains("/search"))
        XCTAssertTrue(url!.absoluteString.contains("q=swift"))
    }

    func test_searchEndpoint_search_givenQueryWithSpaces_encodesCorrectly() {
        let endpoint = SearchEndpoint.search(query: "hello world")
        let url = endpoint.url

        XCTAssertNotNil(url)
        XCTAssertTrue(url!.absoluteString.contains("q=hello"))
    }

    func test_searchEndpoint_method_isGET() {
        let endpoint = SearchEndpoint.search(query: "test")
        XCTAssertEqual(endpoint.method, .GET)
    }

    func test_searchEndpoint_host_isSearch() {
        let endpoint = SearchEndpoint.search(query: "test")
        XCTAssertEqual(endpoint.host.baseURL, APIHost.search.baseURL)
    }
}
