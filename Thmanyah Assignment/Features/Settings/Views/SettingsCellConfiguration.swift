//
//  SettingsCellConfiguration.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 09/03/2026.
//

import UIKit

struct SettingsCellConfiguration {

    let appearanceSegment: UISegmentedControl

    private enum Layout {
        static let horizontalMargin: CGFloat = 2
        static let imageToTextPadding: CGFloat = 6
        static let headerTopMargin: CGFloat = 6
        static let headerBottomMargin: CGFloat = 12
        static let versionVerticalMargin: CGFloat = 8
    }

    private let symbolConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .medium)

    func makeListCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewListCell, SettingsListRow> {
        UICollectionView.CellRegistration { [self] cell, _, row in
            switch row {
            case .sectionHeader(let title):
                configureHeader(cell, title: title)
            case .item(let item):
                configureItem(cell, with: item)
            case .versionFooter(let version):
                configureVersionFooter(cell, version: version)
            case .sectionDivider:
                break
            }
        }
    }

    func makeDividerRegistration() -> UICollectionView.CellRegistration<SettingsDividerCell, SettingsSectionID> {
        UICollectionView.CellRegistration { _, _, _ in }
    }
}

private extension SettingsCellConfiguration {

    func backgroundConfig(style: UIBackgroundConfiguration) -> UIBackgroundConfiguration {
        var backgroundConfiguration = style
        backgroundConfiguration.backgroundColor = .backgroundPrimary
        return backgroundConfiguration
    }

    func configureItem(_ cell: UICollectionViewListCell, with item: SettingsItemDisplayModel) {
        var content = UIListContentConfiguration.cell()
        content.text = item.title
        content.textProperties.font = .settingsCellTitle
        content.textProperties.color = .labelPrimary
        content.secondaryText = item.secondaryText
        content.secondaryTextProperties.font = .bodySecondary
        content.secondaryTextProperties.color = .labelPrimary
        content.prefersSideBySideTextAndSecondaryText = true
        content.image = makeImage(named: item.systemImageName, tint: iconTint(for: item.iconTint))
        content.imageToTextPadding = Layout.imageToTextPadding
        content.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 0, leading: Layout.horizontalMargin, bottom: 0, trailing: Layout.horizontalMargin
        )
        cell.contentConfiguration = content
        cell.backgroundConfiguration = backgroundConfig(style: .listPlainCell())
        cell.accessories = accessories(for: item)
    }

    func configureHeader(_ cell: UICollectionViewListCell, title: String) {
        var content = UIListContentConfiguration.groupedHeader()
        content.text = title
        content.textProperties.font = .settingsSectionTitle
        content.textProperties.color = .labelPrimary
        content.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: Layout.headerTopMargin,
            leading: Layout.horizontalMargin,
            bottom: Layout.headerBottomMargin,
            trailing: Layout.horizontalMargin
        )
        cell.contentConfiguration = content
        cell.backgroundConfiguration = backgroundConfig(style: .clear())
        cell.accessories = []
    }

    func configureVersionFooter(_ cell: UICollectionViewListCell, version: String) {
        let prefix = String(localized: "settings_version_prefix")
        var content = UIListContentConfiguration.cell()
        content.text = "\(prefix) \(version)"
        content.textProperties.font = .appCaption
        content.textProperties.color = .labelSecondary
        content.textProperties.alignment = .natural
        content.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: Layout.versionVerticalMargin,
            leading: Layout.horizontalMargin,
            bottom: Layout.versionVerticalMargin,
            trailing: Layout.horizontalMargin
        )
        cell.contentConfiguration = content
        cell.backgroundConfiguration = backgroundConfig(style: .clear())
        cell.accessories = []
    }

    func accessories(for item: SettingsItemDisplayModel) -> [UICellAccessory] {
        switch item.accessory {
        case .none:
            return []
        case .appearanceSegment:
            let customViewConfiguration = UICellAccessory.CustomViewConfiguration(
                customView: appearanceSegment,
                placement: .trailing(displayed: .always),
                reservedLayoutWidth: .actual
            )
            return [.customView(configuration: customViewConfiguration)]
        }
    }

    func makeImage(named name: String, tint: UIColor) -> UIImage? {
        UIImage(systemName: name, withConfiguration: symbolConfig)?
            .withTintColor(tint, renderingMode: .alwaysOriginal)
    }

    func iconTint(for tint: SettingsItemIconTint) -> UIColor {
        switch tint {
        case .primary: .iconPrimary
        case .gold: .gold500
        }
    }
}
