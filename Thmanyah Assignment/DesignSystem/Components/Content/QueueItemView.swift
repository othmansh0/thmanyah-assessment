//
//  QueueItemView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI
import Kingfisher

struct QueueItemView: View {
    let item: ContentItem

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.cardTitle)
                    .foregroundStyle(Color.labelPrimary)
                    .lineLimit(2)

                HStack(spacing: 6) {
                    Text(durationText)
                        .font(.appCaption)
                        .foregroundStyle(Color.labelSecondary)

                    if let date = releaseDateText {
                        Text("•")
                            .font(.appCaption)
                            .foregroundStyle(Color.labelSecondary)
                        Text(date)
                            .font(.appCaption)
                            .foregroundStyle(Color.labelSecondary)
                    }
                }
            }

            Spacer()

            KFImage(imageURL)
                .placeholder { Color.backgroundSecondary }
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(width: 64, height: 64)
                .clipShape(.rect(cornerRadius: 8))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }

    private var imageURL: URL? {
        switch item {
        case .podcast(let podcast): return podcast.imageURL
        case .episode(let episode): return episode.imageURL
        case .audioBook(let audioBook): return audioBook.imageURL
        case .audioArticle(let audioArticle): return audioArticle.imageURL
        }
    }

    private var title: String {
        switch item {
        case .podcast(let podcast): return podcast.title
        case .episode(let episode): return episode.title
        case .audioBook(let audioBook): return audioBook.title
        case .audioArticle(let audioArticle): return audioArticle.title
        }
    }

    private var durationText: String {
        switch item {
        case .podcast(let podcast): return podcast.duration.formattedDuration
        case .episode(let episode): return episode.duration.formattedDuration
        case .audioBook(let audioBook): return audioBook.duration.formattedDuration
        case .audioArticle(let audioArticle): return audioArticle.duration.formattedDuration
        }
    }

    private var releaseDateText: String? {
        switch item {
        case .podcast: return nil
        case .episode(let episode): return episode.releaseDate?.relativeFormatted
        case .audioBook(let audioBook): return audioBook.releaseDate?.relativeFormatted
        case .audioArticle(let audioArticle): return audioArticle.releaseDate?.relativeFormatted
        }
    }
}
