//
//  HomeRepositoryProtocol.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

protocol HomeRepositoryProtocol {
    func fetchSections(page: Int) async throws -> ([Section], Pagination)
}
