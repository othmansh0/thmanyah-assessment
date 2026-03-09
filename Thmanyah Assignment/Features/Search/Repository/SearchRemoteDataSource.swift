//
//  SearchRemoteDataSource.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

struct SearchRemoteDataSource: SearchDataSourceProtocol {
    let networkService: NetworkServiceProtocol

    func search(query: String) async throws -> [SectionDTO] {
        let response: SearchResponseDTO = try await networkService.request(
            SearchEndpoint.search(query: query)
        )
        return response.sections
    }
}
