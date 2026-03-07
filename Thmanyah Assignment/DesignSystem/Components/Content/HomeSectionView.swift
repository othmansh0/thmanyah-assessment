//
//  HomeSectionView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

struct HomeSectionView: View {
    let section: ContentSectionDisplayModel

    var body: some View {
        switch section.type {
        case .queue:
            QueueSectionView(section: section)
        case .bigSquare:
            BigSquareRowView(section: section)
        case .square:
            SquareRowView(section: section)
        case .twoLinesGrid:
            TwoLinesGridRowView(section: section)
        }
    }
}
