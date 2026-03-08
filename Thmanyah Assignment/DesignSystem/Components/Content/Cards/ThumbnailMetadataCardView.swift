//
//  ThumbnailMetadataCardView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI
import Kingfisher

struct ThumbnailMetadataCardView: View {
    let item: ContentSectionItemDisplayModel
    var onTap: (() -> Void)?

    private let thumbnailSize: CGFloat = 90
    @ScaledMetric(relativeTo: .caption) private var pillPaddingH: CGFloat = 8
    @ScaledMetric(relativeTo: .caption) private var pillPaddingV: CGFloat = 4

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            primaryContent
            Spacer(minLength: 0)
            secondaryActions
        }
        .padding(.vertical, 12)
    }

    @ViewBuilder
    private var primaryContent: some View {
        if let onTap {
            Button(action: onTap) { primaryContentCore }
                .buttonStyle(.plain)
        } else {
            primaryContentCore
        }
    }

    private var primaryContentCore: some View {
        HStack(alignment: .top, spacing: 12) {
            thumbnailImage
            textContent
        }
    }

    private var thumbnailImage: some View {
        KFImage(item.imageURL)
            .placeholder { Color.backgroundSecondary }
            .resizable()
            .aspectRatio(1, contentMode: .fill)
            .frame(width: thumbnailSize, height: thumbnailSize)
            .clipShape(.rect(cornerRadius: 8))
    }

    private var textContent: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let date = item.releaseDateText {
                Text(date)
                    .font(.appCaption)
                    .foregroundStyle(Color.labelSecondary)
            }

            Text(item.title)
                .font(.cardTitle)
                .foregroundStyle(Color.labelPrimary)
                .lineLimit(2)

            Spacer(minLength: 16)

            durationPill
        }
    }

    private var secondaryActions: some View {
        VStack {
            Spacer()
            HStack(spacing: 16) {
                Button {} label: {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.iconPrimary)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(String(localized: "accessibility_more_options"))

                Button {} label: {
                    Image(systemName: "text.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.iconPrimary)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(String(localized: "accessibility_play_queue"))
            }
        }
    }

    private var durationPill: some View {
        Button {} label: {
            HStack(spacing: 4) {
                Image(systemName: "play.fill")
                    .font(.system(size: 9, weight: .bold))
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
