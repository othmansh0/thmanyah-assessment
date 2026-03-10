//
//  SearchRepository.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

struct SearchRepository: SearchRepositoryProtocol {
    let dataSource: SearchDataSourceProtocol

    func search(query: String) async throws -> [ContentItem] {
        do {
            let dtos = try await dataSource.search(query: query)
            return dtos.flatMap { $0.items.map { $0.toDomain() } }
        } catch is CancellationError {
            throw CancellationError()
        } catch {
            throw mapToAppError(error)
        }
    }
}
