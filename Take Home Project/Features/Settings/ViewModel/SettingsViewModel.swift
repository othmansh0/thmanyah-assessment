//
//  SettingsViewModel.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 08/03/2026.
//

import UIKit

enum AppearanceMode: Int, CaseIterable {
    case system = 0
    case light = 1
    case dark = 2

    var title: String {
        switch self {
        case .system: return String(localized: "settings_system")
        case .light:  return String(localized: "settings_light")
        case .dark:   return String(localized: "settings_dark")
        }
    }

    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .system: return .unspecified
        case .light:  return .light
        case .dark:   return .dark
        }
    }
}

@MainActor
final class SettingsViewModel {
    private static let appearanceKey = "app_appearance_mode"

    private let userDefaults: UserDefaults
    private let onStyleChange: (UIUserInterfaceStyle) -> Void

    private(set) var selectedAppearance: AppearanceMode

    var sections: [SettingsSectionDisplayModel] {
        [
            SettingsSectionDisplayModel(
                id: .general,
                title: String(localized: "settings_general"),
                items: [
                    SettingsItemDisplayModel(
                        id: .appearance,
                        title: String(localized: "settings_appearance"),
                        systemImageName: "circle.lefthalf.filled",
                        secondaryText: nil,
                        accessory: .appearanceSegment,
                        iconTint: .primary,
                        isSelectable: false
                    ),
                    SettingsItemDisplayModel(
                        id: .language,
                        title: String(localized: "settings_language"),
                        systemImageName: "globe",
                        secondaryText: currentLanguage,
                        accessory: .none,
                        iconTint: .primary,
                        isSelectable: true
                    ),
                    SettingsItemDisplayModel(
                        id: .notifications,
                        title: String(localized: "settings_notifications"),
                        systemImageName: "bell",
                        secondaryText: nil,
                        accessory: .none,
                        iconTint: .primary,
                        isSelectable: false
                    ),
                    SettingsItemDisplayModel(
                        id: .soundSettings,
                        title: String(localized: "settings_sound_settings"),
                        systemImageName: "headphones",
                        secondaryText: nil,
                        accessory: .none,
                        iconTint: .primary,
                        isSelectable: false
                    ),
                    SettingsItemDisplayModel(
                        id: .downloadSettings,
                        title: String(localized: "settings_download_settings"),
                        systemImageName: "square.and.arrow.down",
                        secondaryText: nil,
                        accessory: .none,
                        iconTint: .primary,
                        isSelectable: false
                    )
                ]
            ),
            SettingsSectionDisplayModel(
                id: .accountInformation,
                title: String(localized: "settings_account_information"),
                items: [
                    SettingsItemDisplayModel(
                        id: .signIn,
                        title: String(localized: "settings_sign_in"),
                        systemImageName: "person",
                        secondaryText: nil,
                        accessory: .none,
                        iconTint: .primary,
                        isSelectable: false
                    ),
                    SettingsItemDisplayModel(
                        id: .premiumSubscription,
                        title: String(localized: "settings_premium_subscription"),
                        systemImageName: "star.hexagon",
                        secondaryText: String(localized: "settings_subscribe_now"),
                        accessory: .none,
                        iconTint: .gold,
                        isSelectable: false
                    ),
                    SettingsItemDisplayModel(
                        id: .import,
                        title: String(localized: "settings_import"),
                        systemImageName: "square.and.arrow.up",
                        secondaryText: nil,
                        accessory: .none,
                        iconTint: .primary,
                        isSelectable: false
                    )
                ]
            ),
            SettingsSectionDisplayModel(
                id: .helpAndPolicies,
                title: String(localized: "settings_help_and_policies"),
                items: [
                    SettingsItemDisplayModel(
                        id: .help,
                        title: String(localized: "settings_help"),
                        systemImageName: "questionmark.bubble",
                        secondaryText: nil,
                        accessory: .none,
                        iconTint: .primary,
                        isSelectable: false
                    ),
                    SettingsItemDisplayModel(
                        id: .privacy,
                        title: String(localized: "settings_privacy"),
                        systemImageName: "shield",
                        secondaryText: nil,
                        accessory: .none,
                        iconTint: .primary,
                        isSelectable: false
                    )
                ]
            )
        ]
    }

    var currentLanguage: String {
        Locale.current.localizedString(forLanguageCode: Locale.current.language.languageCode?.identifier ?? "ar") ?? "العربية"
    }

    var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "\(version) (\(build))"
    }

    init(
        userDefaults: UserDefaults,
        onStyleChange: @escaping (UIUserInterfaceStyle) -> Void
    ) {
        self.userDefaults = userDefaults
        self.onStyleChange = onStyleChange
        let rawValue = userDefaults.integer(forKey: Self.appearanceKey)
        self.selectedAppearance = AppearanceMode(rawValue: rawValue) ?? .system
    }

    func setAppearance(_ mode: AppearanceMode) {
        selectedAppearance = mode
        userDefaults.set(mode.rawValue, forKey: Self.appearanceKey)
        onStyleChange(mode.userInterfaceStyle)
    }

    func restoreAppearance() {
        onStyleChange(selectedAppearance.userInterfaceStyle)
    }

    func handleSelection(for itemID: SettingsItemID) {
        switch itemID {
        case .language:
            openLanguageSettings()
        case .appearance,
             .notifications,
             .soundSettings,
             .downloadSettings,
             .signIn,
             .premiumSubscription,
             .import,
             .help,
             .privacy:
            break
        }
    }

    func openLanguageSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
}
