//
//  SearchDataSourceProtocol.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

protocol SearchDataSourceProtocol: Sendable {
    func search(query: String) async throws -> [SectionDTO]
}
