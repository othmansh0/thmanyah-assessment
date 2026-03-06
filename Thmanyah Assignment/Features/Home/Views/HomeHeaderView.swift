//
//  HomeHeaderView.swift
//  Thmanyah Assignment
//

import SwiftUI

struct HomeHeaderView: View {
    var body: some View {
        HStack {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 6) {
                        Text(greeting)
                            .font(.appTitle)
                            .foregroundStyle(Color.labelPrimary)
                        Circle()
                            .fill(Color.colorSuccess)
                            .frame(width: 8, height: 8)
                    }
                }
                Button(action: {}) {
                    Image(systemName: "gearshape")
                        .foregroundStyle(Color.iconPrimary)
                        .font(.system(size: 20))
                }
            }

            Spacer()

            HStack(spacing: 12) {
                Button(action: {}) {
                    Image(systemName: "bell")
                        .foregroundStyle(Color.iconPrimary)
                        .font(.system(size: 20))
                }
                Circle()
                    .fill(Color.colorSuccess)
                    .frame(width: 36, height: 36)
                    .overlay {
                        Image(systemName: "person.fill")
                            .foregroundStyle(Color.labelOnSolid)
                            .font(.system(size: 16))
                    }
            }
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

#Preview {
    HomeHeaderView()
}
