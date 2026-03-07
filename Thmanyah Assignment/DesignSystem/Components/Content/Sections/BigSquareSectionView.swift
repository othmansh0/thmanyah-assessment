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
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.labelSecondary)
                    .flipsForRightToLeftLayoutDirection(true)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(section.entries) { entry in
                        BigSquareCardView(item: entry)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
        }
    }
}
