//
//  SearchResponseDTO.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 09/03/2026.
//

// Search API response does not include pagination — sections only.
// SectionsResponseDTO cannot be reused here because its pagination property is non-optional.
struct SearchResponseDTO: Decodable {
    let sections: [SectionDTO]
}
