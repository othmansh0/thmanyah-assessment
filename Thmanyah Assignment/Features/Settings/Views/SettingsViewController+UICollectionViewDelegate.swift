//
//  SettingsViewController+UICollectionViewDelegate.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 09/03/2026.
//

import UIKit

extension SettingsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let item = settingsDataSource.item(at: indexPath), item.isSelectable else { return }
        viewModel.handleSelection(for: item.id)
    }

    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        settingsDataSource.item(at: indexPath)?.isSelectable ?? false
    }
}
