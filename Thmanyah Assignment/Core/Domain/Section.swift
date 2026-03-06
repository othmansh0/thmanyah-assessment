//
//  Section.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

struct Section: Identifiable {
    let id: String
    let title: String
    let type: SectionType
    let contentType: ContentType?
    let order: Int
    let items: [ContentItem]
}
