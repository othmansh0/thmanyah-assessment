//
//  HomeViewModel.swift
//  Thmanyah Assignment
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var state: ScreenState<[Section]> = .idle
    @Published private(set) var hasMorePages = true
    @Published var selectedFilter: ContentType? = nil

    private(set) var currentPage = 1
    private var isFetching = false

    var filteredSections: [Section] {
        guard case .loaded(let sections) = state else { return [] }
        guard let filter = selectedFilter else { return sections }
        return sections.filter { $0.contentType == filter }
    }

    private let useCase: FetchHomeSectionsUseCaseProtocol

    init(useCase: FetchHomeSectionsUseCaseProtocol) {
        self.useCase = useCase
    }

    func loadSections() async {
        guard !isFetching else { return }
        isFetching = true
        state = .loading

        do {
            let (newSections, pagination) = try await useCase.execute(page: 1)
            currentPage = 1
            hasMorePages = pagination.hasNextPage
            state = .loaded(newSections)
        } catch {
            state = .failed(error.localizedDescription)
        }

        isFetching = false
    }

    func loadNextPageIfNeeded() async {
        guard !isFetching, hasMorePages, case .loaded(let current) = state else { return }
        isFetching = true

        let nextPage = currentPage + 1
        do {
            let (newSections, pagination) = try await useCase.execute(page: nextPage)
            currentPage = nextPage
            hasMorePages = pagination.hasNextPage
            state = .loaded(current + newSections)
        } catch {}

        isFetching = false
    }

    func retry() async {
        await loadSections()
    }
}
