//
//  SettingsDataSource.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 09/03/2026.
//

import UIKit

@MainActor
final class SettingsDataSource {

    private typealias Snapshot = NSDiffableDataSourceSnapshot<SettingsSectionID, SettingsListRow>
    private typealias DataSource = UICollectionViewDiffableDataSource<SettingsSectionID, SettingsListRow>

    private let dataSource: DataSource

    init(
        collectionView: UICollectionView,
        viewModel: SettingsViewModel,
        appearanceSegment: UISegmentedControl
    ) {
        let configurator = SettingsCellConfiguration(appearanceSegment: appearanceSegment)
        let listCellRegistration = configurator.makeListCellRegistration()
        let dividerRegistration = configurator.makeDividerRegistration()

        self.dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, row in
            switch row {
            case .sectionHeader, .item, .versionFooter:
                return collectionView.dequeueConfiguredReusableCell(
                    using: listCellRegistration,
                    for: indexPath,
                    item: row
                )
            case .sectionDivider(let sectionID):
                return collectionView.dequeueConfiguredReusableCell(
                    using: dividerRegistration,
                    for: indexPath,
                    item: sectionID
                )
            }
        }
    }

    func applySnapshot(sections: [SettingsSectionDisplayModel], appVersion: String, animatingDifferences: Bool = false) {
        var snapshot = Snapshot()
        snapshot.appendSections(sections.map(\.id))

        for (index, section) in sections.enumerated() {
            var rows: [SettingsListRow] = [.sectionHeader(section.title)]
            rows += section.items.map { .item($0) }
            let isLast = index == sections.count - 1
            rows.append(isLast ? .versionFooter(appVersion) : .sectionDivider(section.id))
            snapshot.appendItems(rows, toSection: section.id)
        }

        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    func item(at indexPath: IndexPath) -> SettingsItemDisplayModel? {
        guard case .item(let item) = dataSource.itemIdentifier(for: indexPath) else { return nil }
        return item
    }
}
