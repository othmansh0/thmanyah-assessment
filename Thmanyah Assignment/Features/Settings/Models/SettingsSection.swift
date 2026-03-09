//
//  SettingsSection.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 09/03/2026.
//

import Foundation

enum SettingsSectionID: Int, CaseIterable, Hashable {
    case general
    case accountInformation
    case helpAndPolicies
}

enum SettingsItemID: Int, Hashable {
    case appearance
    case language
    case notifications
    case soundSettings
    case downloadSettings
    case signIn
    case thmanyahSubscription
    case `import`
    case help
    case privacy
}

enum SettingsItemAccessory: Hashable {
    case none
    case appearanceSegment
}

enum SettingsItemIconTint: Hashable {
    case primary
    case gold
}

struct SettingsItemDisplayModel: Identifiable, Hashable {
    let id: SettingsItemID
    let title: String
    let systemImageName: String
    let secondaryText: String?
    let accessory: SettingsItemAccessory
    let iconTint: SettingsItemIconTint
    let isSelectable: Bool
}

struct SettingsSectionDisplayModel: Identifiable, Hashable {
    let id: SettingsSectionID
    let title: String
    let items: [SettingsItemDisplayModel]
}

enum SettingsListRow: Hashable {
    case sectionHeader(String)
    case item(SettingsItemDisplayModel)
    case sectionDivider(SettingsSectionID)
    case versionFooter(String)
}
