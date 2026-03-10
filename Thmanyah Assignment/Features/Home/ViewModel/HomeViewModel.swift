//
//  HomeViewModel.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var state: ScreenState<[Section]> = .idle
    @Published private(set) var hasMorePages = false
    @Published private(set) var isLoadingNextPage = false
    @Published private(set) var filteredSections: [ContentSectionDisplayModel] = []
    @Published var alertError: Error?

    @Published var selectedFilter: HomeFilterChip = .all {
        didSet {
            guard oldValue != selectedFilter else { return }
            recomputeFilteredSections()
        }
    }

    private(set) var currentPage = 1
    private var totalPages = 1
    private var nextPage: Int?
    private var isFetching = false
    private var displayModelCache: [String: ContentSectionDisplayModel] = [:]

    private let container: HomeDIContainerProtocol
    private let sectionMapper = SectionToDisplayMapper()

    init(container: HomeDIContainerProtocol) {
        self.container = container
    }

    func loadSections() async {
        guard !isFetching else { return }
        isFetching = true
        defer { isFetching = false }
        alertError = nil
        isLoadingNextPage = false
        state = .loading

        do {
            let (sections, pagination) = try await container.fetchSectionsUseCase.execute(page: 1)
            guard !Task.isCancelled else { return }
            currentPage = 1
            totalPages = max(pagination.totalPages, 1)
            nextPage = pagination.nextPage
            hasMorePages = currentPage < totalPages
            state = .loaded(sections)
            displayModelCache = [:]
            _ = makeDisplaySections(from: sections, startingAt: 0)
            recomputeFilteredSections()
        } catch is CancellationError {
            return
        } catch {
            let appError = (error as? AppError) ?? .unknown
            state = .failed(appError)
            hasMorePages = false
            totalPages = 1
            nextPage = nil
            isLoadingNextPage = false
        }
    }

    func loadNextPageIfNeeded() async {
        guard
            !isFetching,
            currentPage < totalPages,
            case .loaded(let current) = state
        else {
            return
        }

        let requestedPage = max(nextPage ?? (currentPage + 1), currentPage + 1)

        isFetching = true
        isLoadingNextPage = true
        defer { isFetching = false }

        do {
            let (newSections, pagination) = try await container.fetchSectionsUseCase.execute(page: requestedPage)
            guard !Task.isCancelled else {
                isLoadingNextPage = false
                return
            }
            currentPage = requestedPage
            totalPages = max(pagination.totalPages, currentPage)
            nextPage = pagination.nextPage
            hasMorePages = currentPage < totalPages
            state = .loaded(current + newSections)
            _ = makeDisplaySections(from: newSections, startingAt: displayModelCache.count)
            recomputeFilteredSections()
        } catch is CancellationError {
            isLoadingNextPage = false
            return
        } catch {
            alertError = (error as? AppError) ?? .unknown
            isLoadingNextPage = false
            return
        }

        isLoadingNextPage = false
    }

    func retry() async {
        await loadSections()
    }

    private func recomputeFilteredSections() {
        guard case .loaded(let sections) = state else {
            filteredSections = []
            return
        }

        let filtered: [Section]
        if let filter = selectedFilter.contentType {
            filtered = sections.filter { $0.contentType == filter }
        } else {
            filtered = sections
        }

        let next = filtered.compactMap { displayModelCache[$0.id] }
        guard filteredSections != next else { return }
        filteredSections = next
    }

    private func makeDisplaySections(
        from sections: [Section],
        startingAt offset: Int
    ) -> [ContentSectionDisplayModel] {
        let uncached = sections.filter { displayModelCache[$0.id] == nil }
        let mapped = sectionMapper.map(uncached, startingAt: offset)
        var mappedIndex = 0
        for section in sections where displayModelCache[section.id] == nil {
            displayModelCache[section.id] = mapped[mappedIndex]
            mappedIndex += 1
        }
        return sections.compactMap { displayModelCache[$0.id] }
    }
}
