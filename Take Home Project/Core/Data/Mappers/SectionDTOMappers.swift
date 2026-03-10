//
//  SectionDTOMappers.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

extension SectionDTO {
    func toDomain(pageNumber: Int) -> Section {
        Section(
            id: "\(pageNumber)-\(order)",
            title: name,
            type: SectionType(apiValue: type),
            contentType: contentType.flatMap { ContentType(rawValue: $0) },
            order: order,
            items: items.map { $0.toDomain() }
        )
    }
}
