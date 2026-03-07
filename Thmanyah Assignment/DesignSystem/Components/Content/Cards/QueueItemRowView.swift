//
//  QueueItemRowView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI
import Kingfisher

struct QueueItemRowView: View {
    let item: ContentSectionItemDisplayModel

    var body: some View {
        HStack(spacing: 12) {
            actionColumn

            centerColumn
                .frame(maxWidth: .infinity, alignment: .leading)

            KFImage(item.imageURL)
                .placeholder { Color.backgroundSecondary }
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(width: 72, height: 72)
                .clipShape(.rect(cornerRadius: 8))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }

    private var actionColumn: some View {
        VStack(spacing: 14) {
            Image(systemName: "list.bullet")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color.iconPrimary)

            Image(systemName: "ellipsis")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color.labelSecondary)
        }
    }

    private var centerColumn: some View {
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

            Spacer(minLength: 4)

            durationPill
        }
    }

    private var durationPill: some View {
        HStack(spacing: 4) {
            Image(systemName: "play.fill")
                .font(.system(size: 9, weight: .bold))
            Text(item.durationText)
                .font(.captionMedium)
        }
        .foregroundStyle(Color.labelPrimary)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            Capsule()
                .fill(Color.labelPrimary.opacity(0.12))
        )
    }
}
