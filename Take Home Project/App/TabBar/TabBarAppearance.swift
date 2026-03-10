//
//  TabBarAppearance.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import UIKit

extension AppTabBarRepresentable {
    func applyAppearance(
        to tabBarController: UITabBarController,
        userInterfaceStyle: UIUserInterfaceStyle? = nil
    ) {
        let traitCollection: UITraitCollection
        if let style = userInterfaceStyle {
            traitCollection = UITraitCollection(userInterfaceStyle: style)
        } else {
            traitCollection = tabBarController.traitCollection
        }
        let resolvedColor = UIColor.systemBackground.resolvedColor(with: traitCollection)

        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundEffect = nil
        appearance.backgroundImage = makeFadeGradientImage(
            color: resolvedColor,
            height: TabBarConfig.gradientHeight
        )

        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = .labelSecondary
        itemAppearance.selected.iconColor = .iconPrimary

        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance

        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance
    }

    func makeFadeGradientImage(color: UIColor, height: CGFloat) -> UIImage {
        let size = CGSize(width: 1, height: height)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let cgContext = context.cgContext
            let colors = [
                color.cgColor,
                color.cgColor,
                color.withAlphaComponent(0).cgColor
            ] as CFArray
            let locations: [CGFloat] = [0, TabBarConfig.gradientSolidStop, 1]
            guard let gradient = CGGradient(
                colorsSpace: CGColorSpaceCreateDeviceRGB(),
                colors: colors,
                locations: locations
            ) else { return }
            cgContext.drawLinearGradient(
                gradient,
                start: CGPoint(x: 0.5, y: height),
                end: CGPoint(x: 0.5, y: 0),
                options: []
            )
        }
    }
}
