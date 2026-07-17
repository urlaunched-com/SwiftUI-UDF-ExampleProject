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
import Models
import CustomViews
import Common


public struct ReviewsComponent<R: Routing>: Component where R.Route == ReviewsRoute {
    public struct Props {
        var reviews: [Review.ID]
        var reviewById: (Review.ID) -> Review
        var loadMoreAction: Command
        var dialogStatus: Binding<DialogStatus>
        var router: R = .init()
        var destinationBuilder: DestinationBuilder<ReviewsContent> = .init()
        
        public init(
            reviews: [Review.ID],
            reviewById: @escaping (Review.ID) -> Review,
            loadMoreAction: @escaping Command,
            dialogStatus: Binding<DialogStatus>,
            router: R = .init()
        ) {
            self.reviews = reviews
            self.reviewById = reviewById
            self.loadMoreAction = loadMoreAction
            self.dialogStatus = dialogStatus
            self.router = router
        }
    }
    public var props: Props
    
    public init(props: Props) {
        self.props = props
    }

    @Environment(\.globalRouter) private var globalRouter

    public var body: some View {
        VStack(spacing: 16) {
            List(props.reviews, id: \.self) { id in
                let review = props.reviewById(id)
                ReviewRow(
                    review: review,
                    imageView: props.destinationBuilder.view(
                        for: .imageContainer(
                            path: review.authorDetails.avatarPath,
                            size: CGSize(width: 48, height: 48), type: .profile
                        )
                    )
                )
                .embedInPlainButton {
                    globalRouter.navigate(for: R.self, to: .reviewDetails(id))
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
    ReviewsComponent<MockRouter<ReviewsRoute>>(
        props: .init(
            reviews: Review.testItemIds(count: 10),
            reviewById: { _ in .fakeItem() },
            loadMoreAction: {},
            dialogStatus: .constant(.dismissed)
        )
    )
}
