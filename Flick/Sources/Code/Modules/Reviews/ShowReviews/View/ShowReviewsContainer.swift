//
//  ShowReviewsContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 10.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF
import Models

struct ShowReviewsContainer: BindableContainer {
    typealias ContainerComponent = ReviewsComponent

    let id: Show.ID

    func scope(for state: AppState) -> Scope {
        state.showReviewsFlow[id]
        state.showReviewsForm[id]
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            reviews: form.reviews,
            reviewById: store.state.allReviews.reviewBy,
            loadMoreAction: loadNewPageIfNeeded,
            dialogStatus: store.$state.showReviewsForm[id].dialog
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<AppState>) {
        store.dispatch(
            ActionGroup {
                Actions.SetPaginationItems(
                    items: store.state.allReviews.byShowId[id]?.elements ?? [],
                    id: ShowReviewsFlow.id
                )
                Actions.LoadPage(id: ShowReviewsFlow.id)
            }.binded(to: self)
        )
    }
}

// MARK: - Props

private extension ShowReviewsContainer {
    var form: ShowReviewsForm {
        store.state.showReviewsForm[id] ?? .init()
    }

    var flow: ShowReviewsFlow {
        store.state.showReviewsFlow[id] ?? .init()
    }

    func loadNewPageIfNeeded() {
        guard case let .number(currentPage) = form.page, case .none = flow else { return }

        store.dispatch(
            Actions.LoadPage(
                pageNumber: currentPage + 1,
                id: ShowReviewsFlow.id
            ).binded(to: self)
        )
    }
}
