//
//  PaginationDTO.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

struct PaginationDTO: Decodable, Sendable {
    let nextPage: String?
    let totalPages: Int
}
