//
//  ItemDetailsReviewsComponent.swift
//  Flick
//
//  Created by Alexander Sharko on 08.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import DesignSystem
import Localizations
import SwiftUI
import UDF
import Models
import CustomViews
import Common

public struct ReviewsSectionComponent<R: Routing>: Component where R.Route == ReviewsSectionRoute {
    public struct Props {
        var id: ReviewsTarget
        var reviews: [Review.ID]
        var reviewById: (Review.ID) -> Review
        var isRedacted: Bool
        var router: R = .init()
        
        public init(
            id: ReviewsTarget,
            reviews: [Review.ID],
            reviewById: @escaping (Review.ID) -> Review,
            isRedacted: Bool,
            router: R
        ) {
            self.id = id
            self.reviews = reviews
            self.reviewById = reviewById
            self.isRedacted = isRedacted
            self.router = router
        }
    }

    public var props: Props
    
    public init(props: Props) {
        self.props = props
    }

    @Environment(\.globalRouter) private var globalRouter

    public var body: some View {
        if let id = props.reviews.first {
            VStack(alignment: .leading, spacing: 24) {
                SectionHeaderView(
                    title: Localization.itemDetailsReviewsSectionTitle(props.reviews.count),
                    seeAllAction: {
                        globalRouter.navigate(for: R.self, to: .reviews(props.id))
                    }
                )
                
                let review = props.reviewById(id)
                ReviewRow(review: review, imageView: props.router.view(
                    for: .imageContainer(
                        path: review.authorDetails.avatarPath,
                        size: CGSize(width: 48, height: 48),
                        type: .profile
                    )
                ))
                .embedInPlainButton {
                    globalRouter.navigate(for: R.self, to: .reviewDetails(id))
                }
                .buttonStyle(.scaled)
                .padding(.horizontal)
            }
            .isRedacted(props.isRedacted)
            .disabled(props.isRedacted)
            .toolbar(.hidden, for: .tabBar)
        }
    }
}
