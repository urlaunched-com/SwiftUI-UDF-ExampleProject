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

public struct ItemDetailsReviewsComponent<R: Routing>: Component where R.Route == ItemDetailsReviewsRoute {
    public struct Props {
        var item: any Item
        var reviews: [Review.ID]
        var reviewById: (Review.ID) -> Review
        var isRedacted: Bool
        var router: R = .init()
        var destinationBuilder: DestinationBuilder<ItemDetailsReviewsContent> = .init()
        
        public init(
            item: any Item,
            reviews: [Review.ID],
            reviewById: @escaping (Review.ID) -> Review,
            isRedacted: Bool,
            router: R,
            destinationBuilder: DestinationBuilder<ItemDetailsReviewsContent>
        ) {
            self.item = item
            self.reviews = reviews
            self.reviewById = reviewById
            self.isRedacted = isRedacted
            self.router = router
            self.destinationBuilder = destinationBuilder
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
                        globalRouter.navigate(for: R.self, to: .reviews(props.item))
                    }
                )
                
                let review = props.reviewById(id)
                ReviewRow(review: review, imageView: props.destinationBuilder.view(
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
