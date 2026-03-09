//
//  ContentDetailPlaceholderView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 08/03/2026.
//

import SwiftUI

struct ContentDetailPlaceholderView: View {
    let id: String

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "doc.text")
                .font(.iconXLarge)
                .foregroundStyle(Color.iconPrimary)

            Text(String(format: String(localized: "Detail: %@"), id))
                .font(.appTitle)
                .foregroundStyle(Color.labelPrimary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundPrimary)
    }
}
