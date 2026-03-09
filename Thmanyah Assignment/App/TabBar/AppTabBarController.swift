//
//  AppTabBarController.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import UIKit

final class AppTabBarController: UITabBarController {
    var onTraitChange: (() -> Void)?

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard let previousTraitCollection,
              traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)
        else { return }
        onTraitChange?()
    }
}
