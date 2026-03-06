//
//  SearchRepositoryProtocol.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

protocol SearchRepositoryProtocol: Sendable {
    func search(query: String) async throws -> [Section]
}
