//
//  SearchContentView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 08/03/2026.
//

import SwiftUI

struct SearchContentView: View {
    @ObservedObject var viewModel: SearchViewModel
    @Environment(\.contentItemTapped) private var onItemTapped

    var body: some View {
        stateContent
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.backgroundPrimary)
            .searchable(
                text: $viewModel.query,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: String(localized: "search_placeholder")
            )
    }

    @ViewBuilder
    private var stateContent: some View {
        switch viewModel.state {
        case .idle:
            idleView

        case .searching:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .results(let items):
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(items) { item in
                        ThumbnailMetadataCardView(
                            item: item,
                            onTap: onItemTapped.map { action in { action(item) } }
                        )
                        .padding(.horizontal, 16)
                    }
                }
                .padding(.bottom, 16)
            }

        case .empty:
            EmptyStateView(message: String(localized: "search_no_results"))

        case .failed(let error):
            FailedStateView(error: error) {
                viewModel.retry()
            }
        }
    }

    private var idleView: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))
                .foregroundStyle(Color.labelSecondary)
            Text(String(localized: "search_start"))
                .font(.bodyPrimary)
                .foregroundStyle(Color.labelSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
