//
//  CompactTabBar.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import UIKit

final class CompactTabBar: UITabBar {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = TabBarConfig.barContentHeight + safeAreaInsets.bottom
        return sizeThatFits
    }
}
