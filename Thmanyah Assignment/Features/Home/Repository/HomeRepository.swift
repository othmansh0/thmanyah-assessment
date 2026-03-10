//
//  HomeRepository.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import Foundation

struct HomeRepository: HomeRepositoryProtocol {
    let dataSource: HomeDataSourceProtocol

    func fetchSections(page: Int) async throws -> ([Section], Pagination) {
        do {
            let response = try await dataSource.fetchSections(page: page)
            let sections = response.sections.map { $0.toDomain(pageNumber: page) }
            let pagination = response.pagination.toDomain()
            return (sections, pagination)
        } catch is CancellationError {
            throw CancellationError()
        } catch {
            throw mapToAppError(error)
        }
    }
}
