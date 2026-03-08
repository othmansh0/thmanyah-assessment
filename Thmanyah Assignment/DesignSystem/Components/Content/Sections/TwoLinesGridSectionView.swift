//
//  TwoLinesGridSectionView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

struct TwoLinesGridSectionView: View {
    let section: ContentSectionDisplayModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SectionHeaderView(title: section.title) {
                Image(systemName: "chevron.forward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
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
                    spacing: 12
                ) {
                    ForEach(section.entries) { entry in
                        ThumbnailMetadataCardView(item: entry)
                            .frame(width: geometry.size.width - 48)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .frame(height: 200)
    }

}
