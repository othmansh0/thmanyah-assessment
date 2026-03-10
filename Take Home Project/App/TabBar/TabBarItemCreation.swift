//
//  TabBarItemCreation.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import UIKit

extension AppTabBarRepresentable {
    func makeTabItem(image: UIImage?, accessibilityLabel: String) -> UITabBarItem {
        let item = UITabBarItem(title: "", image: image, selectedImage: image)
        item.imageInsets = UIEdgeInsets(
            top: TabBarConfig.iconVerticalInset,
            left: 0,
            bottom: -TabBarConfig.iconVerticalInset,
            right: 0
        )
        item.accessibilityLabel = accessibilityLabel
        return item
    }

    func makeIcon(named name: String, size: CGFloat) -> UIImage? {
        guard let image = UIImage(named: name)?.withRenderingMode(.alwaysTemplate) else { return nil }
        return resizeToTemplate(image: image, size: size)
    }

    func makeIcon(systemName: String, size: CGFloat) -> UIImage? {
        let config = UIImage.SymbolConfiguration(pointSize: size, weight: .medium)
        guard let symbol = UIImage(systemName: systemName, withConfiguration: config)?
            .withRenderingMode(.alwaysTemplate) else { return nil }
        return resizeToTemplate(image: symbol, size: size)
    }

    private func resizeToTemplate(image: UIImage, size: CGFloat) -> UIImage {
        let targetSize = CGSize(width: size, height: size)
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }.withRenderingMode(.alwaysTemplate)
    }
}
