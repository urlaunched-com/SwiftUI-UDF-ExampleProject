//
//  SectionDetailsRow.swift
//  Flick
//
//  Created by Alexander Sharko on 05.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import DesignSystem
import SwiftUI

struct SectionDetailsRow: View {
    var item: any Item
    var genres: String
    var size: CGSize
    var toggleFavoriteAction: () -> Void
    var shareAction: () -> Void

    var body: some View {
        ZStack(alignment: .bottom) {
            ImageContainer(
                size: size,
                path: item.posterPath
            )
            .frame(size)
            .clipped()

            LinearGradient(
                colors: [.flDark.opacity(0.8), .flDark.opacity(0.7), .clear],
                startPoint: .bottom,
                endPoint: .top
            )
            .frame(height: size.height * 0.6)

            itemInfoView
        }
        .frame(size)
    }
}

private extension SectionDetailsRow {
    var itemInfoView: some View {
        VStack(spacing: 8) {
            Text(genres)
                .customFont(.body)
                .foregroundStyle(.flWhite)
                .lineLimit(1)

            Text(item.title)
                .customFont(.title2)
                .foregroundStyle(.flWhite)
                .multilineTextAlignment(.center)

            HStack(spacing: 16) {
                Text(item.year)
                    .customFont(.body)
                    .foregroundStyle(.flWhite)
                    .frame(maxWidth: .infinity, alignment: .trailing)

                Button(action: toggleFavoriteAction) {
                    Image.heartNormal
                        .aspectFit()
                        .frame(30)
                }
                .buttonStyle(.circle())

                Button(action: shareAction) {
                    Image.logoutRight
                        .aspectFit()
                        .frame(30)
                }
                .buttonStyle(.circle())

                HStack {
                    Image.starFill

                    Text("\(item.rating)%")
                        .customFont(.body)
                        .foregroundStyle(.flWhite)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, 4)
        }
        .padding(.horizontal)
        .padding(.bottom, 24)
    }
}

// MARK: - Preview

#Preview {
    SectionDetailsRow(
        item: Movie.fakeItem(),
        genres: "Fantasy • Action • Adventure",
        size: .init(width: 300, height: 500),
        toggleFavoriteAction: {},
        shareAction: {}
    )
}
