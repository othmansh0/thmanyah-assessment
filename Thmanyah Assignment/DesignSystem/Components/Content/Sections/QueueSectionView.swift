//
//  QueueSectionView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI
import Kingfisher

private enum QueueSectionLayout {
    static let outerHorizontalPadding: CGFloat = 16
    static let cardSize: CGFloat = 120
    static let cardCornerRadius: CGFloat = 12
    static let containerCornerRadius: CGFloat = 16
    static let containerHeight: CGFloat = 160
    static let contentPadding: CGFloat = 16
    static let cardDeckWidth: CGFloat = 155
    static let sectionSpacing: CGFloat = 20
    static let textSpacing: CGFloat = 6
    static let metadataSpacing: CGFloat = 4
    static let playButtonSize: CGFloat = 40
}

struct QueueSectionView: View {
    let section: ContentSectionDisplayModel

    @State private var currentIndex = 0

    private var currentEntry: ContentSectionItemDisplayModel? {
        guard !section.entries.isEmpty else { return nil }
        return section.entries[max(0, min(currentIndex, section.entries.count - 1))]
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeaderView(title: section.title) {
                Image(systemName: "chevron.forward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(Color.labelPrimary)
            }

            HStack(spacing: QueueSectionLayout.sectionSpacing) {
                cardDeckRegion
                    .frame(width: QueueSectionLayout.cardDeckWidth, alignment: .trailing)
                    .padding(.leading, QueueSectionLayout.contentPadding)

                episodeInfoRegion
                    .frame(maxWidth: .infinity)
            }
            .padding(QueueSectionLayout.contentPadding)
            .frame(height: QueueSectionLayout.containerHeight)
            .background(
                Color.profileCardBackground,
                in: RoundedRectangle(cornerRadius: QueueSectionLayout.containerCornerRadius)
            )
            .padding(.horizontal, QueueSectionLayout.outerHorizontalPadding)
        }
    }

    private var cardDeckRegion: some View {
        StackedCardCarouselView(section.entries, currentIndex: $currentIndex) { entry in
            KFImage(entry.imageURL)
                .placeholder {
                    RoundedRectangle(cornerRadius: QueueSectionLayout.cardCornerRadius)
                        .fill(Color.backgroundAccented)
                        .overlay(
                            Image(systemName: "headphones")
                                .font(.system(size: 28))
                                .foregroundStyle(Color.iconPrimary.opacity(0.4))
                        )
                }
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(
                    width: QueueSectionLayout.cardSize,
                    height: QueueSectionLayout.cardSize
                )
                .clipShape(RoundedRectangle(cornerRadius: QueueSectionLayout.cardCornerRadius))
        }
    }

    private var episodeInfoRegion: some View {
        VStack(alignment: .leading, spacing: QueueSectionLayout.textSpacing) {
            if let entry = currentEntry {
                Text(entry.title)
                    .font(.cardTitle)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .transition(.opacity)

                HStack(spacing: QueueSectionLayout.metadataSpacing) {
                    Text(entry.durationText)
                        .font(.captionSemiBold)
                        .foregroundStyle(Color.red600)
                    if let relativeDate = entry.releaseDateText {
                        Text(relativeDate)
                            .font(.appCaption)
                            .foregroundStyle(Color.labelSecondaryMuted)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading) 
                .transition(.opacity)
            }

            Spacer(minLength: 0)
        }
        .animation(.easeInOut(duration: 0.2).delay(0.05), value: currentIndex)
        .overlay(alignment: .bottomTrailing) {
            if currentEntry != nil {
                playButton
            }
        }
    }

    private var playButton: some View {
        Button(action: {}) {
            Image(systemName: "play.fill")
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(.white)
                .frame(
                    width: QueueSectionLayout.playButtonSize,
                    height: QueueSectionLayout.playButtonSize
                )
                .background(Circle().fill(Color.playButtonBackground))
        }
        .buttonStyle(.plain)
        .accessibilityLabel(String(format: String(localized: "accessibility_play_duration"), currentEntry?.title ?? ""))
    }
}
