//
//  HomeHeaderView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

struct HomeHeaderView: View {
    private var placeholderUserName: String {
        String(localized: "home_header_placeholder_name")
    }

    var body: some View {
        HStack(spacing: 10) {
            Circle()
                .fill(Color.accentGreen)
                .frame(width: 40, height: 40)
                .overlay {
                    Image(systemName: "person.fill")
                        .foregroundStyle(Color.labelOnSolid)
                        .font(.system(size: 18))
                }

            HStack(spacing: 6) {
                Text(String(format: String(localized: "home_header_greeting"), greeting, placeholderUserName))
                    .font(.sectionTitle)
                    .foregroundStyle(Color.labelPrimary)
                    .lineLimit(1)

                Image(systemName: "star.hexagon.fill")
                    .foregroundStyle(Color.playButtonBackground)
                    .font(.system(size: 16))
            }

            Spacer()

            Button(action: {}) {
                Image(systemName: "bell")
                    .foregroundStyle(Color.iconPrimary)
                    .font(.system(size: 24))
            }
            .accessibilityLabel(String(localized: "accessibility_notifications"))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.backgroundPrimary)
    }

    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        return hour < 12
            ? String(localized: "greeting_morning")
            : String(localized: "greeting_evening")
    }
}
