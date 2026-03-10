//
//  SearchRepositoryProtocol.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

protocol SearchRepositoryProtocol {
    func search(query: String) async throws -> [ContentItem]
}
