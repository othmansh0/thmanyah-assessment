//
//  HomeContentView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

struct HomeContentView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        VStack(spacing: 0) {
            HomeHeaderView()
            FilterChipBarView(selectedFilter: $viewModel.selectedFilter)
            stateContent
        }
        .background(Color.backgroundPrimary)
        .toolbar(.hidden, for: .navigationBar)
    }

    @ViewBuilder
    private var stateContent: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .loaded:
            HomeSectionsFeedView()
                .environmentObject(viewModel)

        case .failed(let error):
            FailedStateView(error: error) { Task { await viewModel.retry() } }
        }
    }
}

private struct HomeSectionsFeedView: View {
    @EnvironmentObject var viewModel: HomeViewModel

    private let emptyScrollID = "empty"

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    if viewModel.filteredSections.isEmpty {
                        EmptyStateView(message: String(localized: "empty_no_content"))
                            .padding(.top, 60)
                            .id(emptyScrollID)
                    } else {
                        ForEach(viewModel.filteredSections) { section in
                            SectionLayoutView(section: section)
                                .id(section.id)
                        }

                        if viewModel.hasMorePages {
                            paginationTrigger
                        }

                        if viewModel.isLoadingNextPage {
                            paginationFooter
                        }
                    }
                }
                .padding(.bottom, 16)
            }
            .onChange(of: viewModel.selectedFilter) { _ in
                withAnimation(.easeOut(duration: 0.3)) {
                    if let first = viewModel.filteredSections.first {
                        proxy.scrollTo(first.id, anchor: .top)
                    } else {
                        proxy.scrollTo(emptyScrollID, anchor: .top)
                    }
                }
            }
            .refreshable { await viewModel.loadSections() }
        }
    }

    private var paginationFooter: some View {
        ProgressView()
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
    }

    private var paginationTrigger: some View {
        Color.clear
            .frame(height: 1)
            .task { await viewModel.loadNextPageIfNeeded() }
    }
}

