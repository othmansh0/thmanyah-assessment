//
//  SearchRemoteDataSource.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

struct SearchRemoteDataSource: SearchDataSourceProtocol {
    let networkService: NetworkServiceProtocol

    func search(query: String) async throws -> [SectionDTO] {
        // Full implementation in Day 3 once search API response shape is confirmed.
        fatalError("SearchRemoteDataSource.search not yet implemented")
    }
}
