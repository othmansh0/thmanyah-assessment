//
//  BigSquareCardView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI
import Kingfisher

struct BigSquareCardView: View {
    let item: ContentSectionItemDisplayModel

    private let cardSize: CGFloat = 160
    /// Scales with Dynamic Type so pill padding/spacing grows when user increases text size. Uses .caption because the pill content (duration) uses caption-sized font.
    @ScaledMetric(relativeTo: .caption) private var contentSpacing: CGFloat = 4
    @ScaledMetric(relativeTo: .caption) private var pillPaddingH: CGFloat = 8
    @ScaledMetric(relativeTo: .caption) private var pillPaddingV: CGFloat = 6
    
    private var secondaryText: String {
        item.releaseDateText ?? item.credit
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            imageSection
            bottomContentSection
        }
        .frame(width: cardSize)
        .clipShape(.rect(cornerRadius: 12))
    }

    private var imageSection: some View {
        KFImage(item.imageURL)
            .placeholder { Color.backgroundSecondary }
            .resizable()
            .aspectRatio(1, contentMode: .fill)
            .clipShape(.rect(cornerRadius: 12))
    }

    @ViewBuilder
    private var bottomContentSection: some View {
        VStack(alignment: .leading, spacing: contentSpacing) {
            titleLabel
            bottomMetadataRow
        }
    }

    private var titleLabel: some View {
        Text(item.title)
            .font(.cardTitle)
            .foregroundStyle(Color.labelPrimary)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder
    private var bottomMetadataRow: some View {
        HStack(spacing: 8) {
            playButtonPill
            
            if !secondaryText.isEmpty {
                secondaryTextLabel
            }
            Spacer(minLength: 8)
        }
    }

    private var secondaryTextLabel: some View {
        Text(secondaryText)
            .font(.appCaption)
            .foregroundStyle(Color.labelSecondaryMuted)
            .lineLimit(1)
    }

    private var playButtonPill: some View {
        Button {

        } label: {
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

#if DEBUG
struct BigSquareCardView_Previews: PreviewProvider {
    static var previews: some View {
        BigSquareCardView(item: .previewAudioBook)
            .padding()
            .background(Color.backgroundPrimary)
            .previewLayout(.sizeThatFits)
    }
}
#endif
