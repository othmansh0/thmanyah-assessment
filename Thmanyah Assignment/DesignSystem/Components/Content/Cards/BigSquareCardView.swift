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

    private let size: CGFloat = 160

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            KFImage(item.imageURL)
                .placeholder { Color.backgroundSecondary }
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(.rect(cornerRadius: 12))

            Text(item.title)
                .font(.cardTitle)
                .foregroundStyle(Color.labelPrimary)
                .lineLimit(2)
                .frame(width: size, alignment: .leading)

            Text(item.credit)
                .font(.appCaption)
                .foregroundStyle(Color.labelSecondary)
                .lineLimit(1)
                .frame(width: size, alignment: .leading)

            Text(item.durationText)
                .font(.captionMedium)
                .foregroundStyle(Color.labelSecondary)
                .frame(width: size, alignment: .leading)
        }
        .frame(width: size)
    }
}
