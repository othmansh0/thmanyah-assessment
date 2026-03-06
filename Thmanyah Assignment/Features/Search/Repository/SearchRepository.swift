//
//  SearchRepository.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

struct SearchRepository: SearchRepositoryProtocol {
    let dataSource: SearchDataSourceProtocol

    func search(query: String) async throws -> [Section] {
        let dtos = try await dataSource.search(query: query)
        return dtos.map { $0.toDomain() }
    }
}
