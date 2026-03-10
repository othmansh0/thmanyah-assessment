//
//  SettingsDividerCell.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 09/03/2026.
//

import UIKit

final class SettingsDividerCell: UICollectionViewCell {

    private let line = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .backgroundPrimary
        line.backgroundColor = .neutral500
        line.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(line)
        NSLayoutConstraint.activate([
            line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            line.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            line.heightAnchor.constraint(equalToConstant: 1),
            contentView.heightAnchor.constraint(equalToConstant: 9)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
