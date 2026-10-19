//
//  MovieRecommendationsMiddleware.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF
@preconcurrency import Models

public struct RecommendationsEnvironment {
    public var loadMovies: (_ movieId: Movie.ID, _ page: Int) async throws -> [Movie]
    public var loadShows: (_ showId: Show.ID, _ page: Int) async throws -> [Show]

    public init(
        loadMovies: @escaping (_ movieId: Movie.ID, _ page: Int) async throws -> [Movie],
        loadShows: @escaping (_ showId: Show.ID, _ page: Int) async throws -> [Show]
    ) {
        self.loadMovies = loadMovies
        self.loadShows = loadShows
    }
}

enum RecommendationsCancellation: Hashable {
    case load(RecomendationTarget)
}

final class RecommendationsMiddleware<F: ItemDetailsFeature>: Middleware<F>, @unchecked Sendable {

    public typealias Environment = RecommendationsEnvironment
    public var environment: Environment!

    public func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.itemDetailsFeatureState.recommendationsFlow
    }

    public override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    public func observe(state: F) {
        for (id, flow) in state.itemDetailsFeatureState.recommendationsFlow {
            switch (id, flow) {
            case let (.movie(movieID), .load(page)):
                execute(
                    effect: LoadMoviesEffect(
                        movieId: movieID,
                        page: page,
                        environment: environment
                    ),
                    flowId: RecommendationsFlow.id,
                    cancellation: RecommendationsCancellation.load(id),
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
                    cancellation: RecommendationsCancellation.load(id),
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
    static func buildLiveEnvironment(for _: some Store<F>) -> Environment {
        F.Environments.recommendations
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
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
        let environment: RecommendationsMiddleware.Environment

        func task(flowId: AnyHashable) async throws -> any Action {
            guard let movieId else {
                throw CancellationError()
            }
            let movies = try await environment.loadMovies(movieId, page)
            return ActionGroup {
                Actions.DidLoadItems(items: movies, id: flowId)
                Actions.DidLoadNestedItems(parentId: movieId, items: movies)
            }
        }
    }
    
    struct LoadShowsEffect: ConcurrencyEffect {
        let showId: Show.ID?
        let page: Int
        let environment: RecommendationsMiddleware.Environment

        func task(flowId: AnyHashable) async throws -> any Action {
            guard let showId else {
                throw CancellationError()
            }
            let shows = try await environment.loadShows(showId, page)
            return ActionGroup {
                Actions.DidLoadItems(items: shows, id: flowId)
                Actions.DidLoadNestedItems(parentId: showId, items: shows)
            }
        }
    }
}

