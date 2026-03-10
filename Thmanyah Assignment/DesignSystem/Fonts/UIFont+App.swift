//
//  UIFont+App.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import UIKit
import SwiftUI

extension UIFont {
    static func appFont(_ token: AppFont) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: token.textStyle.uiTextStyle)
        guard let font = UIFont(name: token.name, size: token.size) else {
            return metrics.scaledFont(for: UIFont.systemFont(ofSize: token.size))
        }
        return metrics.scaledFont(for: font)
    }

    static var appTitle: UIFont { appFont(.appTitle) }
    static var sectionTitle: UIFont { appFont(.sectionTitle) }
    static var cardTitle: UIFont { appFont(.cardTitle) }
    static var bodyPrimary: UIFont { appFont(.bodyPrimary) }
    static var bodySecondary: UIFont { appFont(.bodySecondary) }
    static var appCaption: UIFont { appFont(.caption) }
    static var captionMedium: UIFont { appFont(.captionMedium) }
    static var chipLabel: UIFont { appFont(.chipLabel) }
    static var buttonLabel: UIFont { appFont(.buttonLabel) }
    static var settingsSectionTitle: UIFont { appFont(.settingsSectionTitle) }
    static var settingsCellTitle: UIFont { appFont(.settingsCellTitle) }
}

private extension Font.TextStyle {
    var uiTextStyle: UIFont.TextStyle {
        switch self {
        case .largeTitle: return .largeTitle
        case .title: return .title1
        case .title2: return .title2
        case .title3: return .title3
        case .headline: return .headline
        case .subheadline: return .subheadline
        case .body: return .body
        case .callout: return .callout
        case .footnote: return .footnote
        case .caption: return .caption1
        case .caption2: return .caption2
        default: return .body
        }
    }
}
