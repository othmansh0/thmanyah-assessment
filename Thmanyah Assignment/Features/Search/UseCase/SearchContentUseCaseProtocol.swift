//
//  SearchContentUseCaseProtocol.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

protocol SearchContentUseCaseProtocol {
    func execute(query: String) async throws -> [Section]
}
