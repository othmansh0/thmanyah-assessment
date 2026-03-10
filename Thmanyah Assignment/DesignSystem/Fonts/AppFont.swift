//
//  AppFont.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import SwiftUI

struct AppFont {
    let name: String
    let size: CGFloat
    let textStyle: Font.TextStyle

    static let regular = "IBMPlexSansArabic-Regular"
    static let medium = "IBMPlexSansArabic-Medium"
    static let semiBold = "IBMPlexSansArabic-SemiBold"
    static let bold = "IBMPlexSansArabic-Bold"

    static let appTitle = AppFont(name: bold, size: 24, textStyle: .title)
    static let sectionTitle = AppFont(name: semiBold, size: 18, textStyle: .headline)
    static let sectionHeader = AppFont(name: bold, size: 20, textStyle: .headline)
    static let cardTitle = AppFont(name: semiBold, size: 14, textStyle: .subheadline)
    static let bodyPrimary = AppFont(name: regular, size: 16, textStyle: .body)
    static let bodySecondary = AppFont(name: regular, size: 14, textStyle: .subheadline)
    static let caption = AppFont(name: regular, size: 12, textStyle: .caption)
    static let captionMedium = AppFont(name: medium, size: 12, textStyle: .caption)
    static let captionSemiBold = AppFont(name: semiBold, size: 12, textStyle: .caption)
    static let chipLabel = AppFont(name: medium, size: 14, textStyle: .subheadline)
    static let buttonLabel = AppFont(name: semiBold, size: 16, textStyle: .body)
    static let settingsSectionTitle = AppFont(name: regular, size: 17, textStyle: .headline)
    static let settingsCellTitle = AppFont(name: bold, size: 14, textStyle: .subheadline)

    // Icon sizing (SF Symbols scale by font size)
    static let iconSmall = AppFont(name: bold, size: 9, textStyle: .caption2)
    static let iconMedium = AppFont(name: bold, size: 13, textStyle: .footnote)
    static let iconLarge = AppFont(name: medium, size: 28, textStyle: .title)
    static let iconXLarge = AppFont(name: medium, size: 48, textStyle: .largeTitle)
}
