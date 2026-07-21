//
//  ShowReviewsMiddleware.swift
//  Flick
//
//  Created by Valentin Petrulia on 15.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import API
import UDF
@preconcurrency import Models

enum Cancellation: Hashable {
    case loadShowReviews(Show.ID)
    case loadMovieReviews(Movie.ID)
}

public final class ReviewsSectionMiddleware<F: ReviewsSectionFeature>: Middleware<F>, @unchecked Sendable {
    public struct Environment: @unchecked Sendable {
        var loadShowReviews: (_ showID: Int, _ page: Int) async throws -> [Review]
        var loadMovieReviews: (_ movieID: Int, _ page: Int) async throws -> [Review]
    }

    public var environment: Environment!

    public func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.reviewsSectionBindableForm
        state.reviewsSectionBindableFlow
    }

    public override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    public func observe(state: F) {
        for (id, flow) in state.reviewsSectionBindableFlow {
            switch (id, flow) {
            case let (.show(showID), .loadReviews(page)):
                execute(
                    effect: LoadShowReviewsEffect(
                        showId: showID,
                        page: page,
                        environment: environment
                    ),
                    flowId: ReviewsSectionFlow.id,
                    cancellation: Cancellation.loadShowReviews(showID),
                    mapAction: {
                        $0.binded(to: F.ReviewsSectionContainerType.self, by: id)
                    }
                )
            case let (.movie(movieID), .loadReviews(page)):
                execute(
                    effect: LoadMovieReviewsEffect(
                        movieId: movieID,
                        page: page,
                        environment: environment
                    ),
                    flowId: ReviewsSectionFlow.id,
                    cancellation: Cancellation.loadMovieReviews(movieID),
                    mapAction: {
                        $0.binded(to: F.ReviewsSectionContainerType.self, by: id)
                    }
                )
            default:
                break
            }
        }
    }
}

// MARK: - Environment build methods
public extension ReviewsSectionMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> Environment {
        .init(
            loadShowReviews: { showID, page in
                try await ItemDetailsAPIClient.loadShowReviews(
                    showId: showID,
                    page: page
                )
                .map(\.asReview)
            },
            loadMovieReviews: { movieID, page in
                try await ItemDetailsAPIClient.loadMovieReviews(
                    movieId: movieID,
                    page: page
                )
                .map(\.asReview)
            }
        )
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        .init(
            loadShowReviews: { _, _ in Review.testItems(count: 3) },
            loadMovieReviews: { _, _ in Review.testItems(count: 3) }
        )
    }
}

// MARK: - Effects
private extension ReviewsSectionMiddleware {
    struct LoadShowReviewsEffect: ConcurrencyEffect {
        let showId: Show.ID?
        let page: Int
        let environment: ReviewsSectionMiddleware.Environment

        func task(flowId: AnyHashable) async throws -> any Action {
            guard let showId else {
                throw CancellationError()
            }
            let reviews = try await environment.loadShowReviews(showId.value, page)
            return ActionGroup {
                Actions.DidLoadItems(items: reviews, id: flowId)
                Actions.DidLoadNestedItems(parentId: showId, items: reviews.ids)
            }
        }
    }
    
    struct LoadMovieReviewsEffect: ConcurrencyEffect {
        let movieId: Movie.ID?
        let page: Int
        let environment: ReviewsSectionMiddleware.Environment

        func task(flowId: AnyHashable) async throws -> any Action {
            guard let movieId else {
                throw CancellationError()
            }
            let reviews = try await environment.loadMovieReviews(movieId.value, page)
            return ActionGroup {
                Actions.DidLoadItems(items: reviews, id: flowId)
                Actions.DidLoadNestedItems(parentId: movieId, items: reviews.ids)
            }
        }
    }
}
