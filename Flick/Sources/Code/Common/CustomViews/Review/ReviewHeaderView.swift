//
//  ReviewHeaderView.swift
//  Flick
//
//  Created by Alexander Sharko on 08.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Localizations
import SwiftUI

struct ReviewHeaderView: View {
    let review: Review
    let size = CGSize(width: 48, height: 48)
    var placeholderColor: Color = .flMain

    var body: some View {
        HStack(spacing: 10) {
            Group {
                if let path = review.authorDetails.avatarPath {
                    ImageContainer(
                        size: size,
                        path: path,
                        type: .profile
                    )
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
    ReviewHeaderView(review: .fakeItem())
}
