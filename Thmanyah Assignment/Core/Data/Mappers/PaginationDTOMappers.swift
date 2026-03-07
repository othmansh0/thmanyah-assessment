//
//  PaginationDTOMappers.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import Foundation

private func parseNextPage(_ string: String?) -> Int? {
    guard let string else { return nil }

    if let pageNumber = Int(string) {
        return pageNumber
    }

    guard let components = URLComponents(string: string) else {
        return nil
    }

    return components.queryItems?
        .first(where: { $0.name == "page" })?
        .value
        .flatMap(Int.init)
}

extension PaginationDTO {
    func toDomain() -> Pagination {
        Pagination(
            totalPages: totalPages,
            nextPage: parseNextPage(nextPage)
        )
    }
}
