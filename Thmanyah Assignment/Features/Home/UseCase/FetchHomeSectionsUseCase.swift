//
//  FetchHomeSectionsUseCase.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

struct FetchHomeSectionsUseCase: FetchHomeSectionsUseCaseProtocol {
    let repository: HomeRepositoryProtocol

    func execute(page: Int) async throws -> ([Section], Pagination) {
        try await repository.fetchSections(page: page)
    }
}
