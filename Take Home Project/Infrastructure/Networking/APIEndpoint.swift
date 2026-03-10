//
//  APIEndpoint.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import Foundation

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE, PATCH
}

enum APIHost {
    case sections
    case search

    var baseURL: String {
        switch self {
        case .sections: return "https://api-v2-b2sit6oh3a-uc.a.run.app"
        case .search:   return "https://mock.apidog.com/m1/735111-711675-default"
        }
    }
}

protocol APIEndpoint {
    var host: APIHost { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
}

extension APIEndpoint {
    var method: HTTPMethod { .GET }
    var queryItems: [URLQueryItem]? { nil }

    var url: URL? {
        guard var components = URLComponents(string: host.baseURL) else { return nil }
        components.path += path
        components.queryItems = queryItems
        return components.url
    }
}
