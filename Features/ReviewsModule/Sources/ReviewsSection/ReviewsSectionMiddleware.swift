//
//  ShowReviewsMiddleware.swift
//  Flick
//
//  Created by Valentin Petrulia on 15.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF
@preconcurrency import Models

public struct ReviewsSectionEnvironment: @unchecked Sendable {
    public var loadShowReviews: (_ showId: Show.ID, _ page: Int) async throws -> [Review]
    public var loadMovieReviews: (_ movieId: Movie.ID, _ page: Int) async throws -> [Review]

    public init(
        loadShowReviews: @escaping (_ showId: Show.ID, _ page: Int) async throws -> [Review],
        loadMovieReviews: @escaping (_ movieId: Movie.ID, _ page: Int) async throws -> [Review]
    ) {
        self.loadShowReviews = loadShowReviews
        self.loadMovieReviews = loadMovieReviews
    }
}

enum ReviewsSectionCancellation: Hashable {
    case loadShowReviews(Show.ID)
    case loadMovieReviews(Movie.ID)
}

final class ReviewsSectionMiddleware<F: ReviewsFeature>: Middleware<F>, @unchecked Sendable {

    public typealias Environment = ReviewsSectionEnvironment
    public var environment: Environment!

    public func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.reviewsFeatureState.reviewsSectionForm
        state.reviewsFeatureState.reviewsSectionFlow
    }

    public override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    public func observe(state: F) {
        for (id, flow) in state.reviewsFeatureState.reviewsSectionFlow {
            switch (id, flow) {
            case let (.show(showID), .loadReviews(page)):
                execute(
                    effect: LoadShowReviewsEffect(
                        showId: showID,
                        page: page,
                        environment: environment
                    ),
                    flowId: ReviewsSectionFlow.id,
                    cancellation: ReviewsSectionCancellation.loadShowReviews(showID),
                    mapAction: {
                        $0.binded(to: ReviewsSectionContainer<F>.self, by: id)
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
                    cancellation: ReviewsSectionCancellation.loadMovieReviews(movieID),
                    mapAction: {
                        $0.binded(to: ReviewsSectionContainer<F>.self, by: id)
                    }
                )
            default:
                break
            }
        }
    }
}

// MARK: - Environment build methods
extension ReviewsSectionMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> Environment {
        F.Environments.reviewsSection
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
        let environment: ReviewsSectionMiddleware.Environment

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
