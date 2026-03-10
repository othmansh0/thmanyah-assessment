//
//  ProfileContentCardView.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 08/03/2026.
//

import SwiftUI
import Kingfisher

struct ProfileContentCardView: View {
    let item: ContentSectionItemDisplayModel
    var onTap: (() -> Void)?

    @ScaledMetric(relativeTo: .body) private var contentPadding: CGFloat = 10
    @ScaledMetric(relativeTo: .body) private var sectionSpacing: CGFloat = 14
    @ScaledMetric(relativeTo: .caption) private var metadataSpacing: CGFloat = 4
    @ScaledMetric(relativeTo: .body) private var avatarSize: CGFloat = 32
    @ScaledMetric(relativeTo: .body) private var iconSize: CGFloat = 28
    @ScaledMetric(relativeTo: .body) private var thumbnailSize: CGFloat = 42
    @ScaledMetric(relativeTo: .body) private var mediaPadding: CGFloat = 8

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
        VStack(alignment: .leading, spacing: sectionSpacing) {
            primaryContent
            mediaDetailsSection
        }
        .padding(contentPadding)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityCardLabel)
    }

    private var primaryContent: some View {
        VStack(alignment: .leading, spacing: sectionSpacing) {
            HStack(alignment: .top, spacing: 12) {
                avatarView
                VStack(alignment: .leading, spacing: sectionSpacing) {
                    nameRow
                    descriptionSection
                }
            }
        }
    }

    private var accessibilityCardLabel: String {
        [item.credit, item.title, item.durationText]
            .filter { !$0.isEmpty }
            .joined(separator: ", ")
    }

    private var avatarView: some View {
        Image(systemName: "person.circle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: avatarSize, height: avatarSize)
            .foregroundStyle(Color.accentGreen)
    }

    private var nameRow: some View {
        HStack(alignment: .center) {
            Text(item.credit)
                .font(.cardTitle)
                .foregroundStyle(Color.labelPrimary)
                .lineLimit(1)
            Spacer(minLength: 8)
            if let timestamp = item.releaseDateText {
                Text(timestamp)
                    .font(.appCaption)
                    .foregroundStyle(Color.labelSecondary)
                    .lineLimit(1)
            }
        }
    }

    @ViewBuilder
    private var descriptionSection: some View {
        if let description = item.description, !description.isEmpty {
            Text(description)
                .font(.bodySecondary)
                .foregroundStyle(Color.labelPrimary)
                .lineLimit(4)
        }
    }

    private var mediaDetailsSection: some View {
        HStack(alignment: .center, spacing: 12) {
            thumbnailImage

            VStack(alignment: .leading, spacing: metadataSpacing) {
                Text(item.title)
                    .font(.cardTitle)
                    .foregroundStyle(Color.labelPrimary)
                    .lineLimit(2)
                Text(item.durationText)
                    .font(.appCaption)
                    .foregroundStyle(Color.labelSecondary)
            }

            Spacer()

            playQueueIcon
        }
        .padding(mediaPadding)
        .background(Color.mediaContainerBackground)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private var playQueueIcon: some View {
        Button {} label: {
            Image("playlist")
                .resizable()
                .scaledToFit()
                .frame(width: iconSize, height: iconSize)
                .foregroundStyle(Color.iconPrimary)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(String(localized: "accessibility_play_queue"))
    }

    private var thumbnailImage: some View {
        KFImage(item.imageURL)
            .placeholder { Color.backgroundSecondary }
            .resizable()
            .aspectRatio(1, contentMode: .fill)
            .frame(width: thumbnailSize, height: thumbnailSize)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .accessibilityHidden(true)
    }
}
