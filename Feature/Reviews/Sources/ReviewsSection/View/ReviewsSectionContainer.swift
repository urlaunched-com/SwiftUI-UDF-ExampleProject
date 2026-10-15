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

struct ReviewsSectionContainer<F: ReviewsFeature>: BindableContainer {
    typealias ContainerComponent = ReviewsSectionComponent<ReviewsSectionRouting<F>>
    let id: ReviewsTarget
    
    init(id: ReviewsTarget) {
        self.id = id
    }

    func scope(for state: F) -> Scope {
        state.allReviews
        state.reviewsFeatureState.reviewsSectionForm[id]
        state.reviewsFeatureState.reviewsSectionFlow[id]
    }

    func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            id: id,
            reviews: isRedacted ? Review.fakeItems().ids : reviews,
            reviewById: reviewById,
            isRedacted: isRedacted,
            router: .init(routing: ReviewsSectionRouting<F>())
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<F>) {
        store.dispatch(Actions.LoadPage(id: ReviewsSectionFlow.id).binded(to: self))
    }
}

// MARK: - Props

private extension ReviewsSectionContainer {
    var flow: ReviewsSectionFlow {
        store.state.reviewsFeatureState.reviewsSectionFlow[id] ?? .init()
    }

    var form: ReviewsSectionForm {
        store.state.reviewsFeatureState.reviewsSectionForm[id] ?? .init()
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
