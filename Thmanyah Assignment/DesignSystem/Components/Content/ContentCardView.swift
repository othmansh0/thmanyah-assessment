//
//  ContentCardView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI
import Kingfisher

struct ContentCardView: View {
    let item: ContentItem

    var body: some View {
        HStack(spacing: 12) {
            KFImage(imageURL)
                .placeholder { Color.backgroundSecondary }
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(width: 56, height: 56)
                .clipShape(.rect(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.cardTitle)
                    .foregroundStyle(Color.labelPrimary)
                    .lineLimit(2)

                Text(subtitle)
                    .font(.appCaption)
                    .foregroundStyle(Color.labelSecondary)
                    .lineLimit(1)
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
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
        case .podcast(let podcast): return "\(podcast.episodeCount) حلقة"
        case .episode(let episode): return episode.podcastName
        case .audioBook(let audioBook): return audioBook.authorName
        case .audioArticle(let audioArticle): return audioArticle.authorName
        }
    }
}
