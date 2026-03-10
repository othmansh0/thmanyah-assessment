//
//  SearchViewModel.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 08/03/2026.
//

import Foundation
import Combine

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var query: String = "" {
        didSet { onQueryChanged() }
    }
    @Published private(set) var state: SearchScreenState = .idle
    @Published var alertError: Error?

    private var searchTask: Task<Void, Never>?
    private var lastSuccessfulQuery: String?

    private let container: SearchDIContainerProtocol
    private let itemMapper = SectionToDisplayMapper()
    private let debounceNanoseconds: UInt64

    init(
        container: SearchDIContainerProtocol,
        debounceNanoseconds: UInt64 = 200_000_000
    ) {
        self.container = container
        self.debounceNanoseconds = debounceNanoseconds
    }

    private func onQueryChanged() {
        searchTask?.cancel()

        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmed.isEmpty else {
            state = .idle
            lastSuccessfulQuery = nil
            return
        }

        guard trimmed != lastSuccessfulQuery else { return }

        searchTask = Task { [weak self] in
            guard let self else { return }

            do {
                try await Task.sleep(nanoseconds: self.debounceNanoseconds)
            } catch {
                return
            }

            await self.performSearch(trimmed)
        }
    }

    private func performSearch(_ query: String) async {
        state = .searching

        do {
            let contentItems = try await container.searchContentUseCase.execute(query: query)

            guard !Task.isCancelled else { return }

            lastSuccessfulQuery = query

            let displayItems = mapToDisplayItems(contentItems)
            state = displayItems.isEmpty ? .empty : .results(displayItems)
        } catch is CancellationError {
            return
        } catch {
            guard !Task.isCancelled else { return }
            let appError = (error as? AppError) ?? .unknown
            alertError = appError
            state = .failed(appError)
        }
    }

    private func mapToDisplayItems(_ items: [ContentItem]) -> [ContentSectionItemDisplayModel] {
        let syntheticSectionID = ContentSectionDisplayID(feedIndex: 0)
        return items.enumerated().map { index, item in
            itemMapper.mapItem(item, sectionID: syntheticSectionID, itemIndex: index)
        }
    }

    func retry() {
        lastSuccessfulQuery = nil
        onQueryChanged()
    }
}
