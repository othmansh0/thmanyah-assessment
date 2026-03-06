//
//  NetworkServiceProtocol.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import Foundation

protocol NetworkServiceProtocol: Sendable {
    func request<T: Decodable & Sendable>(_ endpoint: any APIEndpoint) async throws -> T
}
