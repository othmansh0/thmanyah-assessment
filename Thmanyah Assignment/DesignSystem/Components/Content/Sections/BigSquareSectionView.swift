//
//  BigSquareSectionView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

struct BigSquareSectionView: View {
    let section: ContentSectionDisplayModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SectionHeaderView(title: section.title) {
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.labelPrimary)
                    .flipsForRightToLeftLayoutDirection(true)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(section.entries) { entry in
                        cardView(for: entry)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
        }
    }

    @ViewBuilder
    private func cardView(for entry: ContentSectionItemDisplayModel) -> some View {
        switch section.contentType {
        case .episode:
            BigSquareOverlayCardView(item: entry)
        case .audioBook, .audioArticle, .podcast, .none:
            BigSquareCardView(item: entry)
            
        }
    }
}
