//
//  HomeDIContainer.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

protocol HomeDIContainerProtocol {
    var fetchSectionsUseCase: FetchHomeSectionsUseCaseProtocol { get }
}

struct HomeDIContainer: HomeDIContainerProtocol {
    let fetchSectionsUseCase: FetchHomeSectionsUseCaseProtocol

    init(networkService: NetworkServiceProtocol) {
        let dataSource = HomeRemoteDataSource(networkService: networkService)
        let repository = HomeRepository(dataSource: dataSource)
        self.fetchSectionsUseCase = FetchHomeSectionsUseCase(repository: repository)
    }
}

private struct HomeDIContainerKey: EnvironmentKey {
    static let defaultValue: any HomeDIContainerProtocol = StubHomeDIContainer()
}

extension EnvironmentValues {
    var homeContainer: any HomeDIContainerProtocol {
        get { self[HomeDIContainerKey.self] }
        set { self[HomeDIContainerKey.self] = newValue }
    }
}
