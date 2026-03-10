//
//  TwoLinesGridSectionView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

struct TwoLinesGridSectionView: View {
    let section: ContentSectionDisplayModel
    @Environment(\.contentItemTapped) private var onItemTapped
    @ScaledMetric(relativeTo: .body) private var gridHeight: CGFloat = 200
    @ScaledMetric(relativeTo: .body) private var gridSpacing: CGFloat = 12

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SectionHeaderView(title: section.title) {
                Image(systemName: "chevron.forward")
                    .font(.chipLabel)
                    .foregroundStyle(Color.labelPrimary)
            }

            gridLayout
        }
    }

    private var gridLayout: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(
                    rows: Array(repeating: GridItem(.flexible()), count: 2),
                    spacing: gridSpacing
                ) {
                    ForEach(section.entries) { entry in
                        ThumbnailMetadataCardView(
                            item: entry,
                            onTap: onItemTapped.map { action in { action(entry) } }
                        )
                        .frame(width: geometry.size.width - 48)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .frame(height: gridHeight)
    }
}
