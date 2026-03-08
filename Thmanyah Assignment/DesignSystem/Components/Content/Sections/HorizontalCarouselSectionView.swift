//
//  HorizontalCarouselSectionView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 08/03/2026.
//

import SwiftUI

struct HorizontalCarouselSectionView: View {
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

            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(section.entries) { entry in
                            ProfileContentCardView(item: entry)
                                .frame(width: geometry.size.width - 56)
                                .background(Color.profileCardBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .frame(height: 220)
        }
    }
}
