//
//  HomeEndpoint.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import Foundation

enum HomeEndpoint: APIEndpoint {
    case sections(page: Int)

    var host: APIHost { .sections }
    var path: String { "/home_sections" }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .sections(let page):
            return [URLQueryItem(name: "page", value: "\(page)")]
        }
    }
}
