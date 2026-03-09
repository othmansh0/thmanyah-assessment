//
//  SettingsViewController.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import UIKit

final class SettingsViewController: UIViewController {

    let viewModel: SettingsViewModel

    private lazy var collectionView: UICollectionView = {
        let settingsCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: makeSettingsLayout())
        settingsCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        settingsCollectionView.backgroundColor = .backgroundPrimary
        settingsCollectionView.delegate = self
        view.addSubview(settingsCollectionView)
        return settingsCollectionView
    }()

    lazy var settingsDataSource: SettingsDataSource = {
        SettingsDataSource(
            collectionView: collectionView,
            viewModel: viewModel,
            appearanceSegment: appearanceSegment
        )
    }()

    private lazy var appearanceSegment: UISegmentedControl = {
        let titles = AppearanceMode.allCases.map(\.title)
        let segment = UISegmentedControl(items: titles)
        segment.selectedSegmentIndex = viewModel.selectedAppearance.rawValue
        segment.addTarget(self, action: #selector(appearanceChanged), for: .valueChanged)
        return segment
    }()

    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("Use init(viewModel:)") }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = String(localized: "tab_settings")
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .backgroundPrimary
        applySnapshot()
    }

    private func makeSettingsLayout() -> UICollectionViewLayout {
        var layoutConfiguration = UICollectionViewCompositionalLayoutConfiguration()
        layoutConfiguration.interSectionSpacing = 16

        return UICollectionViewCompositionalLayout(sectionProvider: { _, layoutEnvironment in
            var listConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
            listConfiguration.headerMode = .firstItemInSection
            listConfiguration.footerMode = .none
            listConfiguration.showsSeparators = false
            listConfiguration.headerTopPadding = 0
            let listSection = NSCollectionLayoutSection.list(
                using: listConfiguration,
                layoutEnvironment: layoutEnvironment
            )
            listSection.contentInsetsReference = .safeArea
            listSection.contentInsets = .zero
            return listSection
        }, configuration: layoutConfiguration)
    }

    private func applySnapshot() {
        settingsDataSource.applySnapshot(
            sections: viewModel.sections,
            appVersion: viewModel.appVersion
        )
    }

    @objc private func appearanceChanged(_ sender: UISegmentedControl) {
        guard let mode = AppearanceMode(rawValue: sender.selectedSegmentIndex) else { return }
        viewModel.setAppearance(mode)
    }
}
