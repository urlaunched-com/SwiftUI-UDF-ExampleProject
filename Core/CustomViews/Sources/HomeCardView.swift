//
//  HomeCardView.swift
//  Flick
//
//  Created by Alexander Sharko on 03.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import Common
import Models

public struct HomeCardView<ImageView: View>: View {
    @Environment(\.isRedacted) var isRedacted
    var item: any Item
    var genres: String
    var style: ItemSizeStyle = .default
    var textOpacity: CGFloat = 1
    var imageView: ImageView
    
    public init(
        item: any Item,
        genres: String,
        imageView: ImageView,
        style: ItemSizeStyle = .default,
        textOpacity: CGFloat = 1,
    ) {
        self.item = item
        self.genres = genres
        self.style = style
        self.textOpacity = textOpacity
        self.imageView = imageView
    }

    public var body: some View {
        VStack(spacing: style.isMain ? 12 : 8) {
            PosterImageView(
                year: item.year,
                rating: item.rating,
                imageView: imageView,
                style: style
            )

            if !isRedacted {
                VStack(spacing: style.isMain ? 10 : 4) {
                    Text(item.title)
                        .customFont(style.isMain ? .headline : .caption)
                        .foregroundStyle(.flText)
                    Text(genres)
                        .customFont(style.isMain ? .caption : .caption2)
                        .foregroundStyle(style.isMain ? .flGray : .flPurpleLight)
                }
                .opacity(textOpacity)
            }
        }
        .lineLimit(2)
        .multilineTextAlignment(.center)
        .frame(width: style.isMain ? 202 : 135)
    }
}

// MARK: - Preview

#Preview {
    HomeCardView(
        item: Movie.fakeItem(),
        genres: "",
        imageView: EmptyView()
    )
}
