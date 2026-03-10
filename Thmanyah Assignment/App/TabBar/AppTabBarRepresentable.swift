//
//  AppTabBarRepresentable.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import ObjectiveC.runtime
import SwiftUI
import UIKit

struct AppTabBarRepresentable: UIViewControllerRepresentable {
    let container: AppDIContainer

    func makeUIViewController(context: Context) -> UITabBarController {
        let tabBarController = AppTabBarController()
        tabBarController.onTraitChange = { [weak tabBarController] in
            guard let tabBarController else { return }
            self.applyAppearance(to: tabBarController, userInterfaceStyle: nil)
        }

        let homeController = UIHostingController(
            rootView: HomeScreen().environment(\.homeContainer, container.features.home)
        )
        homeController.tabBarItem = makeTabItem(
            image: makeIcon(named: "home", size: TabBarConfig.iconSize),
            accessibilityLabel: String(localized: "tab_home")
        )

        let searchController = UIHostingController(
            rootView: SearchScreen().environment(\.searchContainer, container.features.search)
        )
        searchController.tabBarItem = makeTabItem(
            image: makeIcon(systemName: "magnifyingglass", size: TabBarConfig.iconSize),
            accessibilityLabel: String(localized: "tab_search")
        )

        let settingsViewModel = SettingsViewModel(
            userDefaults: container.features.settings.userDefaults,
            onStyleChange: { [weak tabBarController] style in
                tabBarController?.view.window?.overrideUserInterfaceStyle = style
                guard let tabBarController else { return }
                self.applyAppearance(to: tabBarController, userInterfaceStyle: style)
            }
        )
        
        let settingsController = SettingsViewController(viewModel: settingsViewModel)
        let settingsNavigationController = UINavigationController(rootViewController: settingsController)
        settingsNavigationController.tabBarItem = makeTabItem(
            image: makeIcon(named: "setting", size: TabBarConfig.iconSize),
            accessibilityLabel: String(localized: "tab_settings")
        )

        tabBarController.viewControllers = [homeController, searchController, settingsNavigationController]

        object_setClass(tabBarController.tabBar, CompactTabBar.self)
        applyAppearance(to: tabBarController, userInterfaceStyle: nil)

        return tabBarController
    }

    func updateUIViewController(_ uiViewController: UITabBarController, context: Context) {}
}
