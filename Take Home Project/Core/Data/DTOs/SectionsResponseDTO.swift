//
//  SectionsResponseDTO.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

struct SectionsResponseDTO: Decodable {
    let sections: [SectionDTO]
    let pagination: PaginationDTO
}
