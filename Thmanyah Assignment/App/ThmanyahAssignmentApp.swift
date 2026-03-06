//
//  ThmanyahAssignmentApp.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import SwiftUI

@main
struct ThmanyahAssignmentApp: App {
    private let container = AppDIContainer()

    var body: some Scene {
        WindowGroup {
            AppTabBarRepresentable(container: container)
                .ignoresSafeArea()
                .onAppear { restoreUserInterfaceStyle() }
        }
    }

    private func restoreUserInterfaceStyle() {
        let rawValue = UserDefaults.standard.integer(forKey: "userInterfaceStyle")
        guard let style = UIUserInterfaceStyle(rawValue: rawValue) else { return }
        setUserInterfaceStyle(style)
    }

    private func setUserInterfaceStyle(_ style: UIUserInterfaceStyle) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        for window in windowScene.windows {
            window.overrideUserInterfaceStyle = style
        }
    }
}
