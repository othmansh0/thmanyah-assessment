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
    private var allSectionDisplayModels: [ContentSectionDisplayModel] = []

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
            currentPage = 1
            totalPages = max(pagination.totalPages, 1)
            nextPage = pagination.nextPage
            hasMorePages = currentPage < totalPages
            state = .loaded(sections)
            allSectionDisplayModels = makeDisplaySections(from: sections, startingAt: 0)
            recomputeFilteredSections()
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
            let displaySectionOffset = allSectionDisplayModels.count
            currentPage = requestedPage
            totalPages = max(pagination.totalPages, currentPage)
            nextPage = pagination.nextPage
            hasMorePages = currentPage < totalPages
            state = .loaded(current + newSections)
            allSectionDisplayModels += makeDisplaySections(
                from: newSections,
                startingAt: displaySectionOffset
            )
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
        guard case .loaded = state else {
            filteredSections = []
            return
        }

        let selectedContentType = selectedFilter.contentType
        let nextFilteredSections: [ContentSectionDisplayModel]
        if let filter = selectedContentType {
            nextFilteredSections = allSectionDisplayModels.filter { $0.contentType == filter }
        } else {
            nextFilteredSections = allSectionDisplayModels
        }

        guard filteredSections != nextFilteredSections else { return }
        filteredSections = nextFilteredSections
    }

    private func makeDisplaySections(
        from sections: [Section],
        startingAt offset: Int
    ) -> [ContentSectionDisplayModel] {
        sectionMapper.map(sections, startingAt: offset)
    }
}
