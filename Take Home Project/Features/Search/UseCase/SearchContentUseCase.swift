//
//  SearchContentUseCase.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

struct SearchContentUseCase: SearchContentUseCaseProtocol {
    let repository: SearchRepositoryProtocol

    func execute(query: String) async throws -> [ContentItem] {
        try await repository.search(query: query)
    }
}
