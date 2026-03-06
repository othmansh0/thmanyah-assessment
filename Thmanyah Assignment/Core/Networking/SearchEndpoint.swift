//
//  SearchEndpoint.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import Foundation

enum SearchEndpoint: APIEndpoint {
    case search(query: String)

    var host: APIHost { .search }
    var path: String { "/search" }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .search(let query):
            return [URLQueryItem(name: "q", value: query)]
        }
    }
}
