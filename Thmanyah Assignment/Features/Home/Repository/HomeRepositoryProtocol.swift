//
//  HomeRepositoryProtocol.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

protocol HomeRepositoryProtocol: Sendable {
    func fetchSections(page: Int) async throws -> ([Section], Pagination)
}
