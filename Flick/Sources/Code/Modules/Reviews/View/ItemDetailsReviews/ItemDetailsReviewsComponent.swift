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

struct ItemDetailsReviewsComponent: Component {
    struct Props {
        var item: any Item
        var reviews: [Review.ID]
        var reviewById: (Review.ID) -> Review
        var isRedacted: Bool
        var router: Router<ItemDetailsReviewsRouting> = .init()
    }

    var props: Props

    @Environment(\.globalRouter) private var globalRouter

    var body: some View {
        if let id = props.reviews.first {
            VStack(alignment: .leading, spacing: 24) {
                SectionHeaderView(
                    title: Localization.itemDetailsReviewsSectionTitle(props.reviews.count),
                    seeAllAction: {
                        globalRouter.navigate(for: ItemDetailsReviewsRouting.self, to: .reviews(props.item))
                    }
                )

                ReviewRow(review: props.reviewById(id))
                    .embedInPlainButton {
                        globalRouter.navigate(for: ItemDetailsReviewsRouting.self, to: .reviewDetails(id))
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
