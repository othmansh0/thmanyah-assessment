//
//  SquareSectionView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

struct SquareSectionView: View {
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
                HStack(spacing: 12) {
                    ForEach(section.entries) { entry in
                        SquareCardView(item: entry)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
        }
    }
}
