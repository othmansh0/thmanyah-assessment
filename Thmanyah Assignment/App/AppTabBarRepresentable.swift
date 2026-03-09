//
//  AppTabBarRepresentable.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import SwiftUI
import UIKit

struct AppTabBarRepresentable: UIViewControllerRepresentable {
    let container: AppDIContainer

    func makeUIViewController(context: Context) -> UITabBarController {
        let tabBar = UITabBarController()

        let homeView = HomeScreen()
            .environment(\.homeContainer, container.features.home)

        let homeVC = UIHostingController(rootView: homeView)
        let homeImage = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        homeVC.tabBarItem = UITabBarItem(
            title: "",
            image: homeImage,
            selectedImage: homeImage
        )
        homeVC.tabBarItem.accessibilityLabel = String(localized: "tab_home")

        let searchView = SearchScreen()
            .environment(\.searchContainer, container.features.search)

        let searchVC = UIHostingController(rootView: searchView)
        let searchImage = UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate)
        searchVC.tabBarItem = UITabBarItem(
            title: "",
            image: searchImage,
            selectedImage: searchImage
        )
        searchVC.tabBarItem.accessibilityLabel = String(localized: "tab_search")

        let settingsVM = SettingsViewModel(
            userDefaults: container.features.settings.userDefaults,
            onStyleChange: { [weak tabBar] style in
                tabBar?.view.window?.overrideUserInterfaceStyle = style
            }
        )
        let settingsVC = SettingsViewController(viewModel: settingsVM)
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        let settingsImage = UIImage(named: "setting")?.withRenderingMode(.alwaysTemplate)
        settingsNav.tabBarItem = UITabBarItem(
            title: "",
            image: settingsImage,
            selectedImage: settingsImage
        )
        settingsNav.tabBarItem.accessibilityLabel = String(localized: "tab_settings")

        tabBar.viewControllers = [homeVC, searchVC, settingsNav]

        configureTabBarAppearance(tabBar)

        return tabBar
    }

    func updateUIViewController(_ uiViewController: UITabBarController, context: Context) {}

    private func configureTabBarAppearance(_ tabBar: UITabBarController) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .backgroundPrimary

        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = .labelSecondary
        itemAppearance.selected.iconColor = .iconPrimary

        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance

        tabBar.tabBar.standardAppearance = appearance
        tabBar.tabBar.scrollEdgeAppearance = appearance
    }
}


