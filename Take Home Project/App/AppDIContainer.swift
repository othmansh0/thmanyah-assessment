//
//  AppDIContainer.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import Foundation

struct AppDIContainer {
    let networkService: NetworkServiceProtocol
    let features: Features

    init(networkService: NetworkServiceProtocol = URLSessionNetworkService()) {
        self.networkService = networkService
        self.features = Features(networkService: networkService)
    }
}

extension AppDIContainer {
    struct Features {
        let home: HomeDIContainer
        let search: SearchDIContainer
        let settings: SettingsDIContainer

        init(networkService: NetworkServiceProtocol) {
            self.home = HomeDIContainer(networkService: networkService)
            self.search = SearchDIContainer(networkService: networkService)
            self.settings = SettingsDIContainer()
        }
    }
}
