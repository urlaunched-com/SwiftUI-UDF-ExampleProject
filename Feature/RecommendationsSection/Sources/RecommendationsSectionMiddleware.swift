//
//  MovieRecommendationsMiddleware.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF
@preconcurrency import Models

enum Cancellation: Hashable {
    case load(RecomendationTarget)
}

final class RecommendationsSectionMiddleware<F: RecommendationsSectionFeature>: Middleware<F>, @unchecked Sendable {
    var environment: RecommendationsSectionEnvironment!

    func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.recommendationsSectionFeatureState.recommendationsSectionFlow
    }

    override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func observe(state: F) {
        for (id, flow) in state.recommendationsSectionFeatureState.recommendationsSectionFlow {
            switch (id, flow) {
            case let (.movie(movieID), .load(page)):
                execute(
                    effect: LoadMoviesEffect(
                        movieId: movieID,
                        page: page,
                        environment: environment
                    ),
                    flowId: RecommendationsSectionFlow.id,
                    cancellation: Cancellation.load(id),
                    mapAction: {
                        $0.binded(to: RecommendationsSectionContainer<F>.self, by: id)
                    }
                )
            case let (.show(showID), .load(page)):
                execute(
                    effect: LoadShowsEffect(
                        showId: showID,
                        page: page,
                        environment: environment
                    ),
                    flowId: RecommendationsSectionFlow.id,
                    cancellation: Cancellation.load(id),
                    mapAction: {
                        $0.binded(to: RecommendationsSectionContainer<F>.self, by: id)
                    }
                )
            default:
                break
            }
        }
    }
}

// MARK: - Environment build methods

extension RecommendationsSectionMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> RecommendationsSectionEnvironment {
        F.RecommendationsSectionEnvironment.recommendationsSectionEnvironment
    }

    static func buildTestEnvironment(for _: some Store) -> RecommendationsSectionEnvironment {
        .init(
            loadMovies: { _, _ in Movie.testItems(count: 3) },
            loadShows: { _, _ in Show.testItems(count: 3) }
        )
    }
}

// MARK: - Effects
private extension RecommendationsSectionMiddleware {
    struct LoadMoviesEffect: ConcurrencyEffect {
        let movieId: Movie.ID?
        let page: Int
        let environment: RecommendationsSectionEnvironment

        func task(flowId: AnyHashable) async throws -> any Action {
            guard let movieId else {
                throw CancellationError()
            }
            let movies = try await environment.loadMovies(movieId, page)
            return ActionGroup {
                Actions.DidLoadItems(items: movies, id: flowId)
                Actions.DidLoadNestedItems(parentId: movieId, items: movies.ids)
            }
        }
    }
    
    struct LoadShowsEffect: ConcurrencyEffect {
        let showId: Show.ID?
        let page: Int
        let environment: RecommendationsSectionEnvironment

        func task(flowId: AnyHashable) async throws -> any Action {
            guard let showId else {
                throw CancellationError()
            }
            let shows = try await environment.loadShows(showId, page)
            return ActionGroup {
                Actions.DidLoadItems(items: shows, id: flowId)
                Actions.DidLoadNestedItems(parentId: showId, items: shows.ids)
            }
        }
    }
}
