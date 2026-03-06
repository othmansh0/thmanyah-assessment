//
//  AppDIContainer.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import Foundation

struct AppDIContainer {
    let networkService: NetworkServiceProtocol
    let home: HomeDIContainer
    let search: SearchDIContainer

    init(networkService: NetworkServiceProtocol = URLSessionNetworkService()) {
        self.networkService = networkService
        self.home = HomeDIContainer(networkService: networkService)
        self.search = SearchDIContainer(networkService: networkService)
    }
}
