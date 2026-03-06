//
//  HomeRemoteDataSource.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

struct HomeRemoteDataSource: HomeDataSourceProtocol {
    let networkService: NetworkServiceProtocol

    func fetchSections(page: Int) async throws -> SectionsResponseDTO {
        try await networkService.request(HomeEndpoint.sections(page: page))
    }
}
