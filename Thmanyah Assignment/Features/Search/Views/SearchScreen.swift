//
//  SearchScreen.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 08/03/2026.
//

import SwiftUI

struct SearchScreen: View {
    @Environment(\.searchContainer) private var container

    var body: some View {
        SearchScreenContent(container: container)
    }
}

private struct SearchScreenContent: View {
    let container: any SearchDIContainerProtocol
    @StateObject private var viewModel: SearchViewModel
    @State private var navigationPath = NavigationPath()

    init(container: any SearchDIContainerProtocol) {
        self.container = container
        _viewModel = StateObject(wrappedValue: SearchViewModel(container: container))
    }

    var body: some View {
        NavigationStack(path: $navigationPath) {
            SearchContentView(viewModel: viewModel)
                .environment(\.contentItemTapped) { entry in
                    navigationPath.append(SearchRoute.from(entry))
                }
                .navigationDestination(for: SearchRoute.self) { route in
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
    }
}
