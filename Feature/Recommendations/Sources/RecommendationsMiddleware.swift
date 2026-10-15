//
//  MovieRecommendationsMiddleware.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF
@preconcurrency import MediaModels

enum Cancellation: Hashable {
    case load(MediaReference)
}

final class RecommendationsMiddleware<F: RecommendationsFeature>: Middleware<F>, @unchecked Sendable {
    var environment: RecommendationsEnvironment!

    func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.recommendationsFeatureState.recommendationsFlow
    }

    override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func observe(state: F) {
        for (id, flow) in state.recommendationsFeatureState.recommendationsFlow {
            switch (id, flow) {
            case let (.movie(movieID), .load(page)):
                execute(
                    effect: LoadMoviesEffect(
                        movieId: movieID,
                        page: page,
                        environment: environment
                    ),
                    flowId: RecommendationsFlow.id,
                    cancellation: Cancellation.load(id),
                    mapAction: {
                        $0.binded(to: RecommendationsContainer<F>.self, by: id)
                    }
                )
            case let (.show(showID), .load(page)):
                execute(
                    effect: LoadShowsEffect(
                        showId: showID,
                        page: page,
                        environment: environment
                    ),
                    flowId: RecommendationsFlow.id,
                    cancellation: Cancellation.load(id),
                    mapAction: {
                        $0.binded(to: RecommendationsContainer<F>.self, by: id)
                    }
                )
            default:
                break
            }
        }
    }
}

// MARK: - Environment build methods

extension RecommendationsMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> RecommendationsEnvironment {
        F.RecommendationsEnvironment.recommendationsEnvironment
    }

    static func buildTestEnvironment(for _: some Store) -> RecommendationsEnvironment {
        .init(
            loadMovies: { _, _ in Movie.testItems(count: 3) },
            loadShows: { _, _ in Show.testItems(count: 3) }
        )
    }
}

// MARK: - Effects

private extension RecommendationsMiddleware {
    struct LoadMoviesEffect: ConcurrencyEffect {
        let movieId: Movie.ID?
        let page: Int
        let environment: RecommendationsEnvironment

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
        let environment: RecommendationsEnvironment

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

