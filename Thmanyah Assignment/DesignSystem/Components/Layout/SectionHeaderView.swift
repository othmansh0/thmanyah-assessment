//
//  SectionHeaderView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

struct SectionHeaderView<Content: View>: View {
    private let title: AttributedString
    @ViewBuilder private let trailing: Content

    init(title: String, @ViewBuilder trailing: () -> Content) {
        self.title = AttributedString(title)
        self.trailing = trailing()
    }

    init(title: AttributedString, @ViewBuilder trailing: () -> Content) {
        self.title = title
        self.trailing = trailing()
    }

    var body: some View {
        HStack(alignment: .center) {
            Text(title)
                .font(.sectionHeader)
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
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(Color.labelPrimary)
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
