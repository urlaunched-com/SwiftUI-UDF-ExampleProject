//
//  ShowReviewsMiddleware.swift
//  Flick
//
//  Created by Valentin Petrulia on 15.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF
@preconcurrency import MediaModels
@preconcurrency import ReviewModels

enum Cancellation: Hashable {
    case loadShowReviews(Show.ID)
    case loadMovieReviews(Movie.ID)
}

final class ReviewsMiddleware<F: ReviewsFeature>: Middleware<F>, @unchecked Sendable {
    var environment: ReviewsEnvironment!

    func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.reviewsFeatureState.reviewsForm
        state.reviewsFeatureState.reviewsFlow
    }

    override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func observe(state: F) {
        for (id, flow) in state.reviewsFeatureState.reviewsFlow {
            switch (id, flow) {
            case let (.show(showID), .loadReviews(page)):
                execute(
                    effect: LoadShowReviewsEffect(
                        showId: showID,
                        page: page,
                        environment: environment
                    ),
                    flowId: ReviewsFlow.id,
                    cancellation: Cancellation.loadShowReviews(showID),
                    mapAction: {
                        $0.binded(to: ReviewsContainer<F>.self, by: id)
                    }
                )
            case let (.movie(movieID), .loadReviews(page)):
                execute(
                    effect: LoadMovieReviewsEffect(
                        movieId: movieID,
                        page: page,
                        environment: environment
                    ),
                    flowId: ReviewsFlow.id,
                    cancellation: Cancellation.loadMovieReviews(movieID),
                    mapAction: {
                        $0.binded(to: ReviewsContainer<F>.self, by: id)
                    }
                )
            default:
                break
            }
        }
    }
}

// MARK: - Environment build methods
extension ReviewsMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> ReviewsEnvironment {
        F.ReviewsEnvironment.reviewsEnvironment
    }

    static func buildTestEnvironment(for _: some Store) -> ReviewsEnvironment {
        .init(
            loadShowReviews: { _, _ in Review.testItems(count: 3) },
            loadMovieReviews: { _, _ in Review.testItems(count: 3) }
        )
    }
}

// MARK: - Effects
private extension ReviewsMiddleware {
    struct LoadShowReviewsEffect: ConcurrencyEffect {
        let showId: Show.ID?
        let page: Int
        let environment: ReviewsEnvironment

        func task(flowId: AnyHashable) async throws -> any Action {
            guard let showId else {
                throw CancellationError()
            }
            let reviews = try await environment.loadShowReviews(showId, page)
            return ActionGroup {
                Actions.DidLoadItems(items: reviews, id: flowId)
                Actions.DidLoadNestedItems(parentId: showId, items: reviews)
            }
        }
    }
    
    struct LoadMovieReviewsEffect: ConcurrencyEffect {
        let movieId: Movie.ID?
        let page: Int
        let environment: ReviewsEnvironment

        func task(flowId: AnyHashable) async throws -> any Action {
            guard let movieId else {
                throw CancellationError()
            }
            let reviews = try await environment.loadMovieReviews(movieId, page)
            return ActionGroup {
                Actions.DidLoadItems(items: reviews, id: flowId)
                Actions.DidLoadNestedItems(parentId: movieId, items: reviews)
            }
        }
    }
}
