//
//  ShowDetailsReviewsContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 08.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF

struct ShowDetailsReviewsContainer: BindableContainer {
    typealias ContainerComponent = ItemDetailsReviewsComponent

    let id: Show.ID

    func scope(for state: AppState) -> Scope {
        state.allReviews
        state.allShows
        state.showDetailsReviewsFlow[id]
        state.showDetailsReviewsForm[id]
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            item: store.state.allShows.showBy(id: id),
            reviews: isRedacted ? Review.fakeItems().ids : reviews,
            reviewById: reviewById,
            isRedacted: isRedacted
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<AppState>) {
        store.dispatch(Actions.LoadPage(id: ShowReviewsFlow.id).binded(to: self))
    }
}

// MARK: - Props

private extension ShowDetailsReviewsContainer {
    var flow: ShowReviewsFlow {
        store.state.showDetailsReviewsFlow[id] ?? .init()
    }

    var form: ShowReviewsForm {
        store.state.showDetailsReviewsForm[id] ?? .init()
    }

    var reviews: [Review.ID] {
        store.state.allReviews.byShowId[id]?.elements ?? []
    }

    func reviewById(_ id: Review.ID) -> Review {
        isRedacted ? Review.fakeItem() : store.state.allReviews.reviewBy(id: id)
    }

    var isRedacted: Bool {
        if case .loadShowReviews = flow, reviews.isEmpty {
            return true
        }
        return false
    }
}
