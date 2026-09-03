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
import SwiftUI

struct ReviewsContainer<F: ReviewsFeature>: BindableContainer {
    public typealias ContainerComponent = ReviewsComponent<F.ReviewsRouting>

    public let id: ReviewsTarget

    public func scope(for state: F) -> Scope {
        state.reviewsFeatureState.reviewsForm[id]
        state.reviewsFeatureState.reviewsFlow[id]
    }
    
    init(id: ReviewsTarget) {
        self.id = id
    }

    public func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            reviews: form.reviews,
            reviewById: store.state.allReviews.by(id:),
            loadMoreAction: loadNewPageIfNeeded,
            dialog: dialog
        )
    }

    public func onContainerDidLoad(store: EnvironmentStore<F>) {
        let reviews: [Review.ID]
        switch id {
        case let .movie(movieID):
            reviews = store.state.allReviews.byMovieId[movieID]?.elements ?? []
        case let .show(showID):
            reviews = store.state.allReviews.byShowId[showID]?.elements ?? []
        }
        store.dispatch(
            ActionGroup {
                Actions.SetPaginationItems(
                    items: reviews,
                    id: ReviewsFlow.id
                )
                Actions.LoadPage(id: ReviewsFlow.id)
            }.binded(to: self)
        )
    }
}

// MARK: - Props

private extension ReviewsContainer {
    var dialog: Binding<DialogStatus> {
        Binding {
            form.dialog
        } set: { newValue in
            store.dispatch(Actions.UpdateFormField(keyPath: \ReviewsForm.dialog, value: newValue).binded(to: self))
        }
    }
    
    var form: ReviewsForm {
        store.state.reviewsFeatureState.reviewsForm[id] ?? .init()
    }

    var flow: ReviewsFlow {
        store.state.reviewsFeatureState.reviewsFlow[id] ?? .init()
    }

    func loadNewPageIfNeeded() {
        guard case let .number(currentPage) = form.page, case .none = flow else {
            return
        }
        store.dispatch(Actions.LoadPage(pageNumber: currentPage + 1, id: ReviewsFlow.id).binded(to: self))
    }
}
