//
//  EmptyStateView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

struct EmptyStateView: View {
    let message: String

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "tray")
                .resizable()
                .frame(width: 36, height: 36)
                .foregroundStyle(Color.labelSecondary)

            Text(message)
                .font(.bodyPrimary)
                .foregroundStyle(Color.labelSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(32)
        .frame(maxWidth: .infinity)
    }
}
