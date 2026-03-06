//
//  SectionsResponseDTO.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

struct SectionsResponseDTO: Decodable, Sendable {
    let sections: [SectionDTO]
    let pagination: PaginationDTO
}
