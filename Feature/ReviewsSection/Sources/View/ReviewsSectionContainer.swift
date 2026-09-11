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

public struct ReviewsSectionContainer<F: ReviewsSectionFeature>: BindableContainer {
    public typealias ContainerComponent = ReviewsSectionComponent<F.ReviewsSectionRouting>
    public let id: ReviewsTarget
    
    public init(id: ReviewsTarget) {
        self.id = id
    }

    public func scope(for state: F) -> Scope {
        state.allReviews
        state.reviewsSectionFeatureState.reviewsSectionForm[id]
        state.reviewsSectionFeatureState.reviewsSectionFlow[id]
    }

    public func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            id: id,
            reviews: isRedacted ? Review.fakeItems().ids : reviews,
            reviewById: reviewById,
            isRedacted: isRedacted,
            router: .init(routing: F.ReviewsSectionRouting())
        )
    }

    public func onContainerDidLoad(store: EnvironmentStore<F>) {
        store.dispatch(Actions.LoadPage(id: ReviewsSectionFlow.id).binded(to: self))
    }
}

// MARK: - Props

private extension ReviewsSectionContainer {
    var flow: ReviewsSectionFlow {
        store.state.reviewsSectionFeatureState.reviewsSectionFlow[id] ?? .init()
    }

    var form: ReviewsSectionForm {
        store.state.reviewsSectionFeatureState.reviewsSectionForm[id] ?? .init()
    }

    var reviews: [Review.ID] {
        form.reviews
    }

    func reviewById(_ id: Review.ID) -> Review {
        isRedacted ? Review.fakeItem() : store.state.allReviews.by(id: id)
    }

    var isRedacted: Bool {
        if case .loadReviews = flow, reviews.isEmpty {
            return true
        }
        return false
    }
}
