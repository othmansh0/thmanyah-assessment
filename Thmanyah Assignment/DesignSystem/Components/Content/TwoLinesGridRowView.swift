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
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.labelSecondary)
                    .flipsForRightToLeftLayoutDirection(true)
            }

            ForEach(section.entries) {
                QueueItemView(item: $0.content)
                Divider()
                    .padding(.leading, 16)
            }
        }
    }
}
