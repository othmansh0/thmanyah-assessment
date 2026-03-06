//
//  HomeDIContainer.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

struct HomeDIContainer {
    let fetchSectionsUseCase: FetchHomeSectionsUseCaseProtocol

    init(networkService: NetworkServiceProtocol) {
        let dataSource = HomeRemoteDataSource(networkService: networkService)
        let repository = HomeRepository(dataSource: dataSource)
        self.fetchSectionsUseCase = FetchHomeSectionsUseCase(repository: repository)
    }
}

private struct HomeDIContainerKey: EnvironmentKey {
    static let defaultValue = HomeDIContainer(networkService: URLSessionNetworkService())
}

extension EnvironmentValues {
    var homeContainer: HomeDIContainer {
        get { self[HomeDIContainerKey.self] }
        set { self[HomeDIContainerKey.self] = newValue }
    }
}
