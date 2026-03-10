//
//  Font+App.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import SwiftUI

extension Font {
    static func appFont(_ token: AppFont) -> Font {
        .custom(token.name, size: token.size, relativeTo: token.textStyle)
    }

    static var appTitle: Font { appFont(.appTitle) }
    static var sectionTitle: Font { appFont(.sectionTitle) }
    static var sectionHeader: Font { appFont(.sectionHeader) }
    static var cardTitle: Font { appFont(.cardTitle) }
    static var bodyPrimary: Font { appFont(.bodyPrimary) }
    static var bodySecondary: Font { appFont(.bodySecondary) }
    static var appCaption: Font { appFont(.caption) }
    static var captionMedium: Font { appFont(.captionMedium) }
    static var captionSemiBold: Font { appFont(.captionSemiBold) }
    static var chipLabel: Font { appFont(.chipLabel) }
    static var buttonLabel: Font { appFont(.buttonLabel) }
    static var iconSmall: Font { appFont(.iconSmall) }
    static var iconMedium: Font { appFont(.iconMedium) }
    static var iconLarge: Font { appFont(.iconLarge) }
    static var iconXLarge: Font { appFont(.iconXLarge) }
}
