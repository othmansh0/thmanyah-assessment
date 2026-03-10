//
//  HorizontalCarouselSectionView.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 08/03/2026.
//

import SwiftUI

struct HorizontalCarouselSectionView: View {
    let section: ContentSectionDisplayModel
    @Environment(\.contentItemTapped) private var onItemTapped
    @ScaledMetric(relativeTo: .body) private var sectionHeight: CGFloat = 220

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SectionHeaderView(title: section.title) {
                Image(systemName: "chevron.forward")
                    .font(.chipLabel)
                    .foregroundStyle(Color.labelPrimary)
            }

            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(section.entries) { entry in
                            ProfileContentCardView(
                                item: entry,
                                onTap: onItemTapped.map { action in { action(entry) } }
                            )
                            .frame(width: geometry.size.width - 56)
                            .background(Color.profileCardBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .frame(height: sectionHeight)
        }
    }
}
