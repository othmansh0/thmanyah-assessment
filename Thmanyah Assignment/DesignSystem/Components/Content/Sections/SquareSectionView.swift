//
//  SquareSectionView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

struct SquareSectionView: View {
    let section: ContentSectionDisplayModel
    @Environment(\.contentItemTapped) private var onItemTapped

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SectionHeaderView(title: section.title) {
                Image(systemName: "chevron.forward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(Color.labelPrimary)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(section.entries) { entry in
                        SquareCardView(
                            item: entry,
                            onTap: onItemTapped.map { action in { action(entry) } }
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
        }
    }
}
