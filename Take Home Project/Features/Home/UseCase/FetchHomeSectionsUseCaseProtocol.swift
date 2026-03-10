//
//  FetchHomeSectionsUseCaseProtocol.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

protocol FetchHomeSectionsUseCaseProtocol {
    func execute(page: Int) async throws -> ([Section], Pagination)
}
