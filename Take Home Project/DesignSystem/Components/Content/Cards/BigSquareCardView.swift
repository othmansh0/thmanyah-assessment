//
//  BigSquareCardView.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI
import Kingfisher

struct BigSquareCardView: View {
    let item: ContentSectionItemDisplayModel
    var onTap: (() -> Void)?

    private let cardSize = CGSize(width: 220, height: 160)
    private let cornerRadius: CGFloat = 10

    @ScaledMetric(relativeTo: .body) private var contentPadding: CGFloat = 12
    @ScaledMetric(relativeTo: .body) private var bottomPadding: CGFloat = 16
    @ScaledMetric(relativeTo: .caption) private var contentSpacing: CGFloat = 6

    @ViewBuilder
    var body: some View {
        if let onTap {
            Button(action: onTap) { cardContent }
                .buttonStyle(.plain)
        } else {
            cardContent
        }
    }

    private var cardContent: some View {
        imageSection
            .frame(width: cardSize.width, height: cardSize.height)
            .overlay { overlayGradient }
            .overlay(alignment: .bottomLeading) { overlayContent }
            .clipShape(.rect(cornerRadius: cornerRadius))
            .accessibilityElement(children: .combine)
            .accessibilityLabel("\(item.title), \(item.credit)")
    }

    private var imageSection: some View {
        KFImage(item.imageURL)
            .placeholder { Color.backgroundSecondary }
            .resizable()
            .aspectRatio(contentMode: .fill)
    }

    private var overlayGradient: some View {
        LinearGradient(
            colors: [
                .clear,
                Color.backgroundScrim.opacity(0.4),
                Color.backgroundScrim
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    private var overlayContent: some View {
        VStack(alignment: .leading, spacing: contentSpacing) {
            titleLabel
            subtitleLabel
        }
        .padding(.horizontal, contentPadding)
        .padding(.top, contentPadding)
        .padding(.bottom, bottomPadding)
    }

    private var titleLabel: some View {
        Text(item.title)
            .font(.cardTitle)
            .foregroundStyle(Color.labelOnSolid)
            .lineLimit(2)
    }

    private var subtitleLabel: some View {
        Text(item.credit)
            .font(.appCaption)
            .foregroundStyle(Color.labelOnSolid.opacity(0.85))
            .lineLimit(1)
    }
}
