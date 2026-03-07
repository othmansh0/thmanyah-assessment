//
//  BigSquareCardView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI
import Kingfisher

struct BigSquareCardView: View {
    let item: ContentItem

    private let size: CGFloat = 160

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            KFImage(imageURL)
                .placeholder { Color.backgroundSecondary }
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(.rect(cornerRadius: 12))

            Text(title)
                .font(.cardTitle)
                .foregroundStyle(Color.labelPrimary)
                .lineLimit(2)
                .frame(width: size, alignment: .leading)

            Text(credit)
                .font(.appCaption)
                .foregroundStyle(Color.labelSecondary)
                .lineLimit(1)
                .frame(width: size, alignment: .leading)

            Text(durationText)
                .font(.captionMedium)
                .foregroundStyle(Color.labelSecondary)
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

    private var credit: String {
        switch item {
        case .podcast(let podcast): return "\(podcast.episodeCount) حلقة"
        case .episode(let episode): return episode.podcastName
        case .audioBook(let audioBook): return audioBook.authorName
        case .audioArticle(let audioArticle): return audioArticle.authorName
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
}
