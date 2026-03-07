//
//  SectionHeaderView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

struct SectionHeaderView<Trailing: View>: View {
    private let title: AttributedString
    private let trailing: Trailing

    init(title: String, @ViewBuilder trailing: () -> Trailing) {
        self.title = AttributedString(title)
        self.trailing = trailing()
    }

    init(title: AttributedString, @ViewBuilder trailing: () -> Trailing) {
        self.title = title
        self.trailing = trailing()
    }

    var body: some View {
        HStack(alignment: .center) {
            Text(title)
                .font(.sectionTitle)
                .foregroundStyle(Color.labelPrimary)
            Spacer()
            trailing
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

#Preview {
    VStack {
        SectionHeaderView(title: "التوصيات") {
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Color.labelSecondary)
                .flipsForRightToLeftLayoutDirection(true)
        }
        SectionHeaderView(title: "الأكثر استماعاً") {
            Text("عرض الكل")
                .font(.appCaption)
                .foregroundStyle(Color.labelSecondary)
        }
        SectionHeaderView(title: "مقالات") {
            EmptyView()
        }
    }
}
