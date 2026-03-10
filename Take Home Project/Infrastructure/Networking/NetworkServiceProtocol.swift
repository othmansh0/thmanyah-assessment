//
//  NetworkServiceProtocol.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: any APIEndpoint) async throws -> T
}
