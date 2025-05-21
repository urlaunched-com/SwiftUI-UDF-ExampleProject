//
//  ReviewsComponent.swift
//  Flick
//
//  Created by Alexander Sharko on 10.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import DesignSystem
import Localizations
import SwiftUI
import UDF

struct ReviewsComponent: Component {
    struct Props {
        var reviews: [Review.ID]
        var reviewById: (Review.ID) -> Review
        var loadMoreAction: Command
        var alertStatus: Binding<AlertBuilder.AlertStatus>
        var router: Router<ReviewsRouting> = .init()
    }

    var props: Props

    @Environment(\.globalRouter) private var globalRouter

    var body: some View {
        VStack(spacing: 16) {
            List(props.reviews, id: \.self) { id in
                ReviewRow(review: props.reviewById(id))
                    .embedInPlainButton {
                        globalRouter.navigate(to: .reviewDetails(id), with: props.router)
                    }
                    .onAppear {
                        if id == props.reviews.last {
                            props.loadMoreAction()
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .listRowBackground(Color.flMain)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .customNavigationTitle(Localization.itemDetailsReviewsNavigationTitle())
        .background(Color.flMain.edgesIgnoringSafeArea(.all))
    }
}

// MARK: - Preview

#Preview {
    ReviewsComponent(
        props: .init(
            reviews: Review.testItemIds(count: 10),
            reviewById: { _ in .fakeItem() },
            loadMoreAction: {},
            alertStatus: .constant(.dismissed)
        )
    )
}
