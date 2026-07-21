//
//  MovieDetailsReviewsContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 08.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF
import Models
import Common
import Reviews

public struct ReviewsSectionContainer<F: ReviewsSectionFeature, R: Routing>: BindableContainer where R.Route == ReviewsSectionRoute {
    public typealias ContainerComponent = ReviewsSectionComponent<R>
    public let id: ReviewsTarget
    
    public init(id: ReviewsTarget) {
        self.id = id
    }

    public func scope(for state: F) -> Scope {
        state.allReviews
        state.reviewsSectionBindableForm[id]
        state.reviewsSectionBindableFlow[id]
    }

    public func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            id: id,
            reviews: isRedacted ? Review.fakeItems().ids : reviews,
            reviewById: reviewById,
            isRedacted: isRedacted,
            router: .init()
        )
    }

    public func onContainerDidLoad(store: EnvironmentStore<F>) {
        store.dispatch(Actions.LoadPage(id: ReviewsSectionFlow.id).binded(to: self))
    }
}

// MARK: - Props

private extension ReviewsSectionContainer {
    var flow: ReviewsSectionFlow {
        store.state.reviewsSectionBindableFlow[id] ?? .init()
    }

    var form: ReviewsSectionForm {
        store.state.reviewsSectionBindableForm[id] ?? .init()
    }

    var reviews: [Review.ID] {
        form.reviews
    }

    func reviewById(_ id: Review.ID) -> Review {
        isRedacted ? Review.fakeItem() : store.state.allReviews.reviewBy(id: id)
    }

    var isRedacted: Bool {
        if case .loadReviews = flow, reviews.isEmpty {
            return true
        }
        return false
    }
}
