//
//  FilterChipBarView.swift
//  Thmanyah Assignment
//

import SwiftUI

struct FilterChipBarView: View {
    @Binding var selectedFilter: ContentType?

    private struct Chip {
        let label: String
        let filter: ContentType?
    }

    private let chips: [Chip] = [
        Chip(label: String(localized: "filter_for_you"),       filter: nil),
        Chip(label: String(localized: "filter_podcasts"),      filter: .podcast),
        Chip(label: String(localized: "filter_audio_articles"),filter: .audioArticle),
        Chip(label: String(localized: "filter_books"),         filter: .audioBook),
    ]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(chips, id: \.label) { chip in
                    chipButton(chip)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }

    @ViewBuilder
    private func chipButton(_ chip: Chip) -> some View {
        let isActive = chip.filter == selectedFilter
        Button {
            selectedFilter = chip.filter
        } label: {
            Text(chip.label)
                .font(.chipLabel)
                .foregroundStyle(isActive ? Color.labelOnSolid : Color.labelSecondary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background {
                    if isActive {
                        Capsule().fill(Color.chipActiveBackground)
                    } else {
                        Capsule().stroke(Color.separatorPrimary, lineWidth: 1)
                    }
                }
        }
        .buttonStyle(.plain)
    }
}
