//
//  SearchDIContainer.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import SwiftUI

struct SearchDIContainer {
    let searchContentUseCase: SearchContentUseCaseProtocol

    init(networkService: NetworkServiceProtocol) {
        let dataSource = SearchRemoteDataSource(networkService: networkService)
        let repository = DefaultSearchRepository(remoteDataSource: dataSource)
        self.searchContentUseCase = SearchContentUseCase(repository: repository)
    }
}

private struct SearchDIContainerKey: EnvironmentKey {
    static let defaultValue = SearchDIContainer(networkService: URLSessionNetworkService())
}

extension EnvironmentValues {
    var searchContainer: SearchDIContainer {
        get { self[SearchDIContainerKey.self] }
        set { self[SearchDIContainerKey.self] = newValue }
    }
}

protocol SearchContentUseCaseProtocol: Sendable {
    func execute(query: String) async throws -> [Section]
}

struct SearchContentUseCase: SearchContentUseCaseProtocol {
    let repository: SearchRepositoryProtocol

    func execute(query: String) async throws -> [Section] {
        try await repository.search(query: query)
    }
}

protocol SearchRepositoryProtocol: Sendable {
    func search(query: String) async throws -> [Section]
}

struct DefaultSearchRepository: SearchRepositoryProtocol {
    let remoteDataSource: SearchRemoteDataSource

    func search(query: String) async throws -> [Section] {
        try await remoteDataSource.search(query: query)
    }
}

struct SearchRemoteDataSource: Sendable {
    let networkService: NetworkServiceProtocol

    func search(query: String) async throws -> [Section] {
        fatalError("Not yet implemented")
    }
}
