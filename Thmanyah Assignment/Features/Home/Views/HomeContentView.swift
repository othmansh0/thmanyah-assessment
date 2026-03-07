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
            HomeFailedStateView(
                error: error,
                onRetry: { Task { await viewModel.retry() } }
            )
        }
    }
}

private struct HomeSectionsFeedView: View {
    @EnvironmentObject var viewModel: HomeViewModel

    private let scrollTopID = "homeScrollTop"

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    scrollTopAnchor

                    if viewModel.filteredSections.isEmpty {
                        EmptyStateView(message: String(localized: "empty_no_content"))
                            .padding(.top, 60)
                    }

                    ForEach(viewModel.filteredSections) { section in
                        HomeSectionView(section: section)
                    }

                    if viewModel.hasMorePages {
                        paginationTrigger
                    }

                    if viewModel.isLoadingNextPage {
                        paginationFooter
                    }
                }
                .padding(.bottom, 16)
            }
            .onChange(of: viewModel.selectedFilter) { _ in
                withAnimation(.easeOut(duration: 0.3)) {
                    proxy.scrollTo(scrollTopID, anchor: .top)
                }
            }
        }
    }

    private var scrollTopAnchor: some View {
        Color.clear
            .frame(height: 0)
            .id(scrollTopID)
            .accessibilityHidden(true)
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

private struct HomeFailedStateView: View {
    let error: Error
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.appTitle)
                .foregroundStyle(Color.colorError)

            Text(errorTitle)
                .font(.appTitle)
                .foregroundStyle(Color.labelPrimary)
                .multilineTextAlignment(.center)

            Text(errorMessage)
                .font(.bodyPrimary)
                .foregroundStyle(Color.labelSecondary)
                .multilineTextAlignment(.center)

            Button(action: onRetry) {
                Text(String(localized: "error_retry"))
                    .font(.buttonLabel)
                    .foregroundStyle(Color.labelOnSolid)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.ctaSolidBackground, in: Capsule())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 24)
    }

    private var errorTitle: String {
        localizedError?.errorDescription ?? String(localized: "app_error_unknown")
    }

    private var errorMessage: String {
        localizedError?.recoverySuggestion ?? String(localized: "app_error_recovery_suggestion")
    }

    private var localizedError: LocalizedError? {
        error as? LocalizedError
    }
}
