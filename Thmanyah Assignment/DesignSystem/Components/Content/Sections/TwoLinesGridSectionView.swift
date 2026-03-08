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
        VStack(spacing: 0) {
            SectionHeaderView(title: section.title) {
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.labelPrimary)
                    .flipsForRightToLeftLayoutDirection(true)
            }

            ForEach(section.entries) { entry in
                QueueItemRowView(item: entry)
                Divider()
                    .padding(.leading, 16)
            }
        }
    }
}
