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
    let container: HomeDIContainer
    @StateObject private var viewModel: HomeViewModel

    init(container: HomeDIContainer) {
        self.container = container
        _viewModel = StateObject(wrappedValue: HomeViewModel(container: container))
    }

    var body: some View {
        HomeContentView(viewModel: viewModel)
            .errorAlert(error: $viewModel.alertError)
            .task { await viewModel.loadSections() }
    }
}
