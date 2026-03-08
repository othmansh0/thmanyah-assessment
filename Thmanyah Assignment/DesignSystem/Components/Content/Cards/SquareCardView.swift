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

    private let size: CGFloat = 120

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            KFImage(item.imageURL)
                .placeholder { Color.backgroundSecondary }
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(.rect(cornerRadius: 8))

            Text(item.title)
                .font(.cardTitle)
                .foregroundStyle(Color.labelPrimary)
                .lineLimit(2)
                .frame(width: size, alignment: .leading)

            Text(item.compactSubtitle)
                .font(.appCaption)
                .foregroundStyle(Color.labelSecondary)
                .lineLimit(1)
                .frame(width: size, alignment: .leading)
        }
        .frame(width: size)
    }
}

#if DEBUG
struct SquareCardView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 12) {
            SquareCardView(item: .previewPodcast)
            SquareCardView(item: .previewAudioArticle)
        }
        .padding()
        .background(Color.backgroundPrimary)
        .previewLayout(.sizeThatFits)
    }
}
#endif
