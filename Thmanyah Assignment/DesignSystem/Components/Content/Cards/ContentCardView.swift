//
//  ContentCardView.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI
import Kingfisher

struct ContentCardView: View {
    let item: ContentSectionItemDisplayModel

    var body: some View {
        HStack(spacing: 12) {
            KFImage(item.imageURL)
                .placeholder { Color.backgroundSecondary }
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(width: 56, height: 56)
                .clipShape(.rect(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.cardTitle)
                    .foregroundStyle(Color.labelPrimary)
                    .lineLimit(2)

                Text(item.credit)
                    .font(.appCaption)
                    .foregroundStyle(Color.labelSecondary)
                    .lineLimit(1)
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

#if DEBUG
struct ContentCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentCardView(item: .previewAudioArticle)
            .background(Color.backgroundPrimary)
            .previewLayout(.sizeThatFits)
    }
}
#endif
