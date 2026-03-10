//
//  SearchDIContainer.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

protocol SearchDIContainerProtocol {
    var searchContentUseCase: SearchContentUseCaseProtocol { get }
}

struct SearchDIContainer: SearchDIContainerProtocol {
    let searchContentUseCase: SearchContentUseCaseProtocol

    init(networkService: NetworkServiceProtocol) {
        let dataSource = SearchRemoteDataSource(networkService: networkService)
        let repository = SearchRepository(dataSource: dataSource)
        self.searchContentUseCase = SearchContentUseCase(repository: repository)
    }
}

private struct SearchDIContainerKey: EnvironmentKey {
    static let defaultValue: any SearchDIContainerProtocol = StubSearchDIContainer()
}

extension EnvironmentValues {
    var searchContainer: any SearchDIContainerProtocol {
        get { self[SearchDIContainerKey.self] }
        set { self[SearchDIContainerKey.self] = newValue }
    }
}
