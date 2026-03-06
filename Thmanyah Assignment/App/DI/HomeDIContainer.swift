//
//  HomeDIContainer.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import SwiftUI

struct HomeDIContainer {
    let fetchSectionsUseCase: FetchHomeSectionsUseCaseProtocol

    init(networkService: NetworkServiceProtocol) {
        let dataSource = HomeRemoteDataSource(networkService: networkService)
        let repository = DefaultHomeRepository(remoteDataSource: dataSource)
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

protocol FetchHomeSectionsUseCaseProtocol: Sendable {
    func execute(page: Int) async throws -> ([Section], Pagination)
}

struct FetchHomeSectionsUseCase: FetchHomeSectionsUseCaseProtocol {
    let repository: HomeRepositoryProtocol

    func execute(page: Int) async throws -> ([Section], Pagination) {
        try await repository.fetchSections(page: page)
    }
}

protocol HomeRepositoryProtocol: Sendable {
    func fetchSections(page: Int) async throws -> ([Section], Pagination)
}

struct DefaultHomeRepository: HomeRepositoryProtocol {
    let remoteDataSource: HomeRemoteDataSource

    func fetchSections(page: Int) async throws -> ([Section], Pagination) {
        try await remoteDataSource.fetchSections(page: page)
    }
}

struct HomeRemoteDataSource: Sendable {
    let networkService: NetworkServiceProtocol

    func fetchSections(page: Int) async throws -> ([Section], Pagination) {
        fatalError("Not yet implemented")
    }
}

struct Section: Identifiable, Sendable {
    let id: String
    let title: String
    let type: SectionType
    let contentType: ContentType?
    let items: [ContentItem]
}

enum SectionType: Sendable {
    case queue
    case bigSquare
    case square
    case twoLinesGrid

    init(apiValue: String) {
        switch apiValue {
        case "queue": self = .queue
        case "big_square", "big square": self = .bigSquare
        case "square": self = .square
        case "2_lines_grid": self = .twoLinesGrid
        default: self = .square
        }
    }
}

enum ContentType: String, Sendable {
    case podcast
    case audioArticle = "audio_article"
    case audioBook = "audio_book"
}

struct ContentItem: Identifiable, Sendable {
    let id: String
    let title: String
    let imageURL: URL?
    let duration: Int?
}

struct Pagination: Sendable {
    let currentPage: Int
    let totalPages: Int
    var hasMorePages: Bool { currentPage < totalPages }
}
