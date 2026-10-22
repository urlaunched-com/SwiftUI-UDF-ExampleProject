//
//  PosterImageView.swift
//  Flick
//
//  Created by Oksana Fedorchuk on 22.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SDWebImageSwiftUI
import SwiftUI
import Common

public struct PosterImageView<ImageView: View>: View {
    @Environment(\.isRedacted) var isRedacted
    var year: String
    var rating: Int
    var style: ItemSizeStyle = .default
    var imageView: ImageView
    
    public init(
        year: String,
        rating: Int,
        imageView: ImageView,
        style: ItemSizeStyle = .default,
    ) {
        self.year = year
        self.rating = rating
        self.imageView = imageView
        self.style = style
    }

    public var body: some View {
        imageView
            .frame(width: style.coverSize.width, height: style.coverSize.height)
            .overlay(cardOverlayView, alignment: .bottom)
            .animatedRedacted(isRedacted)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    var cardOverlayView: some View {
        HStack(spacing: 4) {
            Text(year)
            Spacer()
            Image
                .starFill
                .resizable()
                .frame(width: style.isMain ? 12 : 9, height: style.isMain ? 12 : 9)
            Text("\(rating)%")
        }
        .frame(height: style.isMain ? 42 : 26)
        .customFont(style.isMain ? .body : .caption2)
        .foregroundStyle(.flWhite)
        .padding(.horizontal, style.isMain ? 12 : 16)
        .background(Material.thinMaterial)
    }
}

// MARK: - Preview

#Preview {
    PosterImageView(
        year: Date.testItem.asYearString,
        rating: 63,
        imageView: EmptyView()
    )
}
