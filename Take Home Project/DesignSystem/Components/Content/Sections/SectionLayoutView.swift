//
//  SectionLayoutView.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

struct SectionLayoutView: View {
    let section: ContentSectionDisplayModel

    var body: some View {
        switch section.layoutType {
        case .stackedCarousel:
            QueueSectionView(section: section)
        case .bigSquare:
            BigSquareSectionView(section: section)
        case .square:
            SquareSectionView(section: section)
        case .twoRowGrid:
            TwoLinesGridSectionView(section: section)
        case .horizontalCarousel:
            HorizontalCarouselSectionView(section: section)
        }
    }
}
