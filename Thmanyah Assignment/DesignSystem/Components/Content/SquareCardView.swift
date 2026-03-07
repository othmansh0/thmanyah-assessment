//
//  SquareCardView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI
import Kingfisher

struct SquareCardView: View {
    let item: ContentItem

    private let size: CGFloat = 120

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            KFImage(imageURL)
                .placeholder { Color.backgroundSecondary }
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(.rect(cornerRadius: 8))

            Text(title)
                .font(.cardTitle)
                .foregroundStyle(Color.labelPrimary)
                .lineLimit(2)
                .frame(width: size, alignment: .leading)

            Text(subtitle)
                .font(.appCaption)
                .foregroundStyle(Color.labelSecondary)
                .lineLimit(1)
                .frame(width: size, alignment: .leading)
        }
        .frame(width: size)
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

    private var subtitle: String {
        switch item {
        case .podcast(let podcast): return String(format: String(localized: "episodes_count"), podcast.episodeCount)
        case .episode(let episode): return episode.duration.formattedDuration
        case .audioBook(let audioBook): return audioBook.duration.formattedDuration
        case .audioArticle(let audioArticle): return audioArticle.duration.formattedDuration
        }
    }
}
