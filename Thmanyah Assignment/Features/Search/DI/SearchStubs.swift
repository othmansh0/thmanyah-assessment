//
//  SearchStubs.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

struct StubSearchContentUseCase: SearchContentUseCaseProtocol {
    func execute(query: String) async throws -> [Section] {
        []
    }
}

struct StubSearchDIContainer: SearchDIContainerProtocol {
    let searchContentUseCase: SearchContentUseCaseProtocol = StubSearchContentUseCase()
}
