//
//  SquareCardView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI
import Kingfisher

struct SquareCardView: View {
    let item: ContentSectionItemDisplayModel
    var onTap: (() -> Void)?

    private let cardSize: CGFloat = 160
    @ScaledMetric(relativeTo: .subheadline) private var titleHeight: CGFloat = 36
    @ScaledMetric(relativeTo: .caption) private var contentSpacing: CGFloat = 4
    @ScaledMetric(relativeTo: .caption) private var pillPaddingH: CGFloat = 8
    @ScaledMetric(relativeTo: .caption) private var pillPaddingV: CGFloat = 6

    private var secondaryText: String {
        item.releaseDateText ?? item.credit
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            primaryTappableContent
            bottomMetadataRow
        }
        .frame(width: cardSize)
    }

    @ViewBuilder
    private var primaryTappableContent: some View {
        if let onTap {
            Button(action: onTap) { primaryContent }
                .buttonStyle(.plain)
        } else {
            primaryContent
        }
    }

    private var primaryContent: some View {
        VStack(alignment: .leading, spacing: contentSpacing) {
            imageSection
            titleLabel
        }
    }

    private var bottomMetadataRow: some View {
        HStack(spacing: 8) {
            playButtonPill
            if !secondaryText.isEmpty {
                if let onTap {
                    Button(action: onTap) { secondaryTextLabel }
                        .buttonStyle(.plain)
                } else {
                    secondaryTextLabel
                }
            }
            Spacer()
        }
    }

    private var imageSection: some View {
        KFImage(item.imageURL)
            .placeholder { Color.backgroundSecondary }
            .resizable()
            .aspectRatio(1, contentMode: .fill)
            .clipShape(.rect(cornerRadius: 12))
    }

    private var titleLabel: some View {
        Text(item.title)
            .font(.cardTitle)
            .foregroundStyle(Color.labelPrimary)
            .lineLimit(1)
    }

    private var secondaryTextLabel: some View {
        Text(secondaryText)
            .font(.appCaption)
            .foregroundStyle(Color.labelSecondaryMuted)
            .lineLimit(1)
    }

    private var playButtonPill: some View {
        Button {} label: {
            HStack(spacing: 6) {
                Image(systemName: "play.fill")
                    .font(.system(size: 12, weight: .medium))
                Text(item.durationText)
                    .font(.captionMedium)
                    .fixedSize()
            }
            .foregroundStyle(Color.labelOnSolid)
            .padding(.horizontal, pillPaddingH)
            .padding(.vertical, pillPaddingV)
            .background(Capsule().fill(Color.playPillBackground))
        }
        .buttonStyle(.plain)
        .accessibilityLabel(String(format: String(localized: "accessibility_play_duration"), item.durationText))
    }
}
