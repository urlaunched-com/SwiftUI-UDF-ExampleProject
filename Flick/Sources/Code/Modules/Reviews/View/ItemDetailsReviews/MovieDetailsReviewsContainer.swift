//
//  MovieDetailsReviewsContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 08.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF
import Models
import ItemDetailsReviewsComponent
import Common

struct MovieDetailsReviewsContainer: BindableContainer {
    typealias ContainerComponent = ItemDetailsReviewsComponent<ItemDetailsReviewsRouting>
    let id: Movie.ID

    func scope(for state: AppState) -> Scope {
        state.allMovies
        state.allReviews
        state.movieDetailsReviewsFlow[id]
        state.movieDetailsReviewsFlow[id]
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            item: store.state.allMovies.movieBy(id: id),
            reviews: isRedacted ? Review.fakeItems().ids : reviews,
            reviewById: reviewById,
            isRedacted: isRedacted,
            router: .init(),
            destinationBuilder: DestinationBuilder<ItemDetailsReviewsContent>.init(destination: { value in
                switch value {
                case let .imageContainer(path: path, size: size, type: type):
                    ImageContainer(size: size, path: path, type: type)
                }
            })
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<AppState>) {
        store.dispatch(Actions.LoadPage(id: MovieReviewsFlow.id).binded(to: self))
    }
}

// MARK: - Props

private extension MovieDetailsReviewsContainer {
    var flow: MovieReviewsFlow {
        store.state.movieDetailsReviewsFlow[id] ?? .init()
    }

    var form: MovieReviewsForm {
        store.state.movieDetailsReviewsForm[id] ?? .init()
    }

    var reviews: [Review.ID] {
        store.state.allReviews.byMovieId[id]?.elements ?? []
    }

    func reviewById(_ id: Review.ID) -> Review {
        isRedacted ? Review.fakeItem() : store.state.allReviews.reviewBy(id: id)
    }

    var isRedacted: Bool {
        if case .loadMovieReviews = flow, reviews.isEmpty {
            return true
        }
        return false
    }
}
