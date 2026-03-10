//
//  SectionHeaderView.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

struct SectionHeaderView<Content: View>: View {
    private let title: AttributedString
    @ViewBuilder private let trailing: Content

    init(title: String, @ViewBuilder trailingContent: () -> Content) {
        self.title = AttributedString(title)
        self.trailing = trailingContent()
    }

    init(title: AttributedString, @ViewBuilder trailingContent: () -> Content) {
        self.title = title
        self.trailing = trailingContent()
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
