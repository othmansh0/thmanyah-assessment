//
//  FetchHomeSectionsUseCaseProtocol.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

protocol FetchHomeSectionsUseCaseProtocol: Sendable {
    func execute(page: Int) async throws -> ([Section], Pagination)
}
