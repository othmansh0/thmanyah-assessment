//
//  HomeDataSourceProtocol.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

protocol HomeDataSourceProtocol {
    func fetchSections(page: Int) async throws -> SectionsResponseDTO
}
