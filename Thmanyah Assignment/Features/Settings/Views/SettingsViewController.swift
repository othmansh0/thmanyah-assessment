//
//  SettingsViewController.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import UIKit

final class SettingsViewController: UIViewController {
    private let container: SettingsDIContainer

    init(container: SettingsDIContainer) {
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Use init(container:)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPrimary

        let label = UILabel()
        label.text = String(localized: "tab_settings")
        label.font = .appTitle
        label.textColor = .labelPrimary
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
