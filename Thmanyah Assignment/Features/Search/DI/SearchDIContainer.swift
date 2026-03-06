//
//  SearchDIContainer.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

struct SearchDIContainer {
    let searchContentUseCase: SearchContentUseCaseProtocol

    init(networkService: NetworkServiceProtocol) {
        let dataSource = SearchRemoteDataSource(networkService: networkService)
        let repository = SearchRepository(dataSource: dataSource)
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
