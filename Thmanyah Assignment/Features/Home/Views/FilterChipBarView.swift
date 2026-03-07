//
//  FilterChipBarView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

struct FilterChipBarView: View {
    @Binding var selectedFilter: HomeFilterChip

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(HomeFilterChip.allCases) { chip in
                    chipButton(chip)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }

    @ViewBuilder
    private func chipButton(_ chip: HomeFilterChip) -> some View {
        let isActive = chip == selectedFilter
        Button {
            selectedFilter = chip
        } label: {
            Text(chip.localizedTitle)
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
