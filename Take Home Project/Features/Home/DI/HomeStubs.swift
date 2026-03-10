//
//  HomeStubs.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

struct StubHomeSectionsUseCase: FetchHomeSectionsUseCaseProtocol {
    func execute(page: Int) async throws -> ([Section], Pagination) {
        ([], Pagination(totalPages: 1, nextPage: nil))
    }
}

struct StubHomeDIContainer: HomeDIContainerProtocol {
    let fetchSectionsUseCase: FetchHomeSectionsUseCaseProtocol = StubHomeSectionsUseCase()
}
