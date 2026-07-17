//
//  ReviewDetailsComponent.swift
//  Flick
//
//  Created by Alexander Sharko on 10.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import DesignSystem
import Localizations
import SwiftUI
import UDF
import Models
import CustomViews
import Common

public struct ReviewDetailsComponent: Component {
    public struct Props {
        var review: Review
        var destinationBuilder: DestinationBuilder<ReviewDetailsContent>
        
        public init(review: Review, destinationBuilder: DestinationBuilder<ReviewDetailsContent> = .init()) {
            self.review = review
            self.destinationBuilder = destinationBuilder
        }
    }
    
    public init(props: Props) {
        self.props = props
    }

    public var props: Props

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ReviewHeaderView(
                    review: props.review,
                    placeholderColor: .flSecondary,
                    imageView: props.destinationBuilder.view(
                        for: .imageContainer(
                            path: props.review.authorDetails.avatarPath,
                            size: CGSize(width: 48, height: 48),
                            type: .profile
                        )
                    )
                )
                .padding(.horizontal, 10)
                
                Text(props.review.content)
                    .customFont(.body)
                    .foregroundStyle(.flText)
            }
            .padding()
        }
        .customNavigationTitle(Localization.itemDetailsReviewsNavigationTitle())
        .background(Color.flMain.edgesIgnoringSafeArea(.all))
    }
}

// MARK: - Preview

#Preview {
    ReviewDetailsComponent(
        props: .init(
            review: .fakeItem()
        )
    )
}
