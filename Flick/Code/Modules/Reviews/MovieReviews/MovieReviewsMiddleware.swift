//
//  MovieReviewsMiddleware.swift
//  Flick
//
//  Created by Valentin Petrulia on 15.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import API
import UDF

final class MovieReviewsMiddleware: BaseObservableMiddleware<AppState> {
    enum Cancellation: Hashable {
        case loadMovieReviews(Movie.ID)
    }

    struct Environment {
        var loadMovieReviews: (_ movieId: Int, _ page: Int) async throws -> [Review]
    }

    var environment: Environment!

    func scope(for state: AppState) -> Scope {
        state.networkConnectivityForm
        state.movieReviewsFlow
        state.movieDetailsReviewsFlow
    }

    override func status(for state: AppState) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func observe(state: AppState) {
        for (id, flow) in state.movieReviewsFlow {
            switch flow {
            case let .loadMovieReviews(page):
                execute(
                    effect: LoadMovieReviewsEffect(
                        movieId: id,
                        page: page,
                        environment: environment
                    ),
                    flowId: MovieReviewsFlow.id,
                    cancellation: Cancellation.loadMovieReviews(id),
                    mapAction: {
                        $0.binded(to: state.movieReviewsFlow.containerType, by: id)
                    }
                )
            default:
                break
            }
        }

        for (id, flow) in state.movieDetailsReviewsFlow {
            switch flow {
            case let .loadMovieReviews(page):
                execute(
                    effect: LoadMovieReviewsEffect(
                        movieId: id,
                        page: page,
                        environment: environment
                    ),
                    flowId: MovieReviewsFlow.id,
                    cancellation: Cancellation.loadMovieReviews(id),
                    mapAction: {
                        $0.binded(to: state.movieDetailsReviewsFlow.containerType, by: id)
                    }
                )
            default:
                break
            }
        }
    }
}

// MARK: - Environment build methods

extension MovieReviewsMiddleware {
    static func buildLiveEnvironment(for _: some Store<AppState>) -> Environment {
        .init(
            loadMovieReviews: { movieId, page in
                try await ItemDetailsAPIClient.loadMovieReviews(
                    movieId: movieId,
                    page: page
                )
                .map(\.asReview)
            }
        )
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        .init(
            loadMovieReviews: { _, _ in Review.testItems(count: 3) }
        )
    }
}

// MARK: - Effects

private extension MovieReviewsMiddleware {
    struct LoadMovieReviewsEffect: ConcurrencyEffect {
        let movieId: Movie.ID?
        let page: Int
        let environment: MovieReviewsMiddleware.Environment

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
