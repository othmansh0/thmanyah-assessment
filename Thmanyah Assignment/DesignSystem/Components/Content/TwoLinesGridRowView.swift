//
//  TwoLinesGridRowView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

struct TwoLinesGridRowView: View {
    let section: ContentSectionDisplayModel

    var body: some View {
        VStack(spacing: 0) {
            SectionHeaderView(title: section.title) {
                Image(systemName: "chevron.right")
                    .font(.chipLabel)
                    .foregroundStyle(Color.labelSecondary)
                    .flipsForRightToLeftLayoutDirection(true)
            }

            ForEach(section.entries) { entry in
                QueueItemView(item: entry)
                Divider()
                    .padding(.leading, 16)
            }
        }
    }
}
