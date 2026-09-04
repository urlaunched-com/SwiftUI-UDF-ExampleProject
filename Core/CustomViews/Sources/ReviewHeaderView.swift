//
//  ReviewHeaderView.swift
//  Flick
//
//  Created by Alexander Sharko on 08.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Localizations
import SwiftUI
import Models
import DesignSystem

public struct ReviewHeaderView<ImageView: View>: View {
    let review: Review
    let size: CGSize
    var placeholderColor: Color
    var imageView: ImageView
    
    public init(
        review: Review,
        size: CGSize = CGSize(width: 48, height: 48),
        placeholderColor: Color = .flMain,
        imageView: ImageView = EmptyView()
    ) {
        self.review = review
        self.size = size
        self.placeholderColor = placeholderColor
        self.imageView = imageView
    }

    public var body: some View {
        HStack(spacing: 10) {
            Group {
                if let path = review.authorDetails.avatarPath {
                    imageView
                } else {
                    placeholderColor
                        .overlay(
                            Image.castPlaceholder
                                .aspectFit()
                                .frame(35)
                        )
                }
            }
            .frame(size)
            .clipShape(Circle())

            Text(Localization.itemDetailsReviewHeaderTitle(review.authorDetails.username))
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)

            if let rating = review.authorDetails.rating {
                ReviewRatingView(rating: rating)
            }
        }
        .customFont(.callout)
        .foregroundStyle(.flGray)
    }
}

// MARK: - Preview

#Preview {
    ReviewHeaderView<EmptyView>(review: .fakeItem())
}
