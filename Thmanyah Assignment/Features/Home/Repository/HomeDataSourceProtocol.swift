//
//  HomeDataSourceProtocol.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

protocol HomeDataSourceProtocol: Sendable {
    func fetchSections(page: Int) async throws -> SectionsResponseDTO
}
