//
//  HomeScreen.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

struct HomeScreen: View {
    @Environment(\.homeContainer) private var container

    var body: some View {
        HomeScreenContent(container: container)
    }
}

private struct HomeScreenContent: View {
    let container: any HomeDIContainerProtocol
    @StateObject private var viewModel: HomeViewModel
    @State private var navigationPath = NavigationPath()

    init(container: any HomeDIContainerProtocol) {
        self.container = container
        _viewModel = StateObject(wrappedValue: HomeViewModel(container: container))
    }

    var body: some View {
        NavigationStack(path: $navigationPath) {
            HomeContentView(viewModel: viewModel)
                .environment(\.contentItemTapped) { entry in
                    navigationPath.append(HomeRoute.from(entry))
                }
                .navigationDestination(for: HomeRoute.self) { route in
                    switch route {
                    case .podcastDetail(let id),
                         .episodeDetail(let id),
                         .audioBookDetail(let id),
                         .audioArticleDetail(let id):
                        ContentDetailPlaceholderView(id: id)
                    }
                }
        }
        .errorAlert(error: $viewModel.alertError)
        .task { await viewModel.loadSections() }
    }
}
