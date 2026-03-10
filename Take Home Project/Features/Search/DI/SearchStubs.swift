//
//  SearchStubs.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

struct StubSearchContentUseCase: SearchContentUseCaseProtocol {
    func execute(query: String) async throws -> [ContentItem] {
        []
    }
}

struct StubSearchDIContainer: SearchDIContainerProtocol {
    let searchContentUseCase: SearchContentUseCaseProtocol = StubSearchContentUseCase()
}
