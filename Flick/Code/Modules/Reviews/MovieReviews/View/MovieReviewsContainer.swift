//
//  MovieReviewsContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 10.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF

struct MovieReviewsContainer: BindableContainer {
    typealias ContainerComponent = ReviewsComponent

    let id: Movie.ID

    func scope(for state: AppState) -> Scope {
        state.movieReviewsFlow[id]
        state.movieReviewsForm[id]
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            reviews: form.reviews,
            reviewById: store.state.allReviews.reviewBy,
            loadMoreAction: loadNewPageIfNeeded,
            alertStatus: store.$state.movieReviewsForm[id].alert
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<AppState>) {
        store.dispatch(
            ActionGroup {
                Actions.SetPaginationItems(
                    items: store.state.allReviews.byMovieId[id]?.elements ?? [],
                    id: MovieReviewsFlow.id
                )
                Actions.LoadPage(id: MovieReviewsFlow.id)
            }.binded(to: self)
        )
    }
}

// MARK: - Props

private extension MovieReviewsContainer {
    var form: MovieReviewsForm {
        store.state.movieReviewsForm[id] ?? .init()
    }

    var flow: MovieReviewsFlow {
        store.state.movieReviewsFlow[id] ?? .init()
    }

    func loadNewPageIfNeeded() {
        guard case let .number(currentPage) = form.page, case .none = flow else { return }

        store.dispatch(
            Actions.LoadPage(
                pageNumber: currentPage + 1,
                id: MovieReviewsFlow.id
            ).binded(to: self)
        )
    }
}
