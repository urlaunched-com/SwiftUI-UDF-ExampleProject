//
//  MovieRecommendationsMiddleware.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF
@preconcurrency import Models

public struct RecommendationsSectionEnvironment {
    public var loadMovies: (_ movieId: Int, _ page: Int) async throws -> [Movie]
    public var loadShows: (_ showId: Int, _ page: Int) async throws -> [Show]

    public init(
        loadMovies: @escaping (_ movieId: Int, _ page: Int) async throws -> [Movie],
        loadShows: @escaping (_ showId: Int, _ page: Int) async throws -> [Show]
    ) {
        self.loadMovies = loadMovies
        self.loadShows = loadShows
    }
}

enum RecommendationsSectionCancellation: Hashable {
    case load(RecomendationTarget)
}

final class RecommendationsSectionMiddleware<F: ItemDetailsFeature>: Middleware<F>, @unchecked Sendable {

    public typealias Environment = RecommendationsSectionEnvironment
    public var environment: Environment!

    public func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.itemDetailsFeatureState.recommendationsSectionFlow
    }

    public override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    public func observe(state: F) {
        for (id, flow) in state.itemDetailsFeatureState.recommendationsSectionFlow {
            switch (id, flow) {
            case let (.movie(movieID), .load(page)):
                execute(
                    effect: LoadMoviesEffect(
                        movieId: movieID,
                        page: page,
                        environment: environment
                    ),
                    flowId: RecommendationsSectionFlow.id,
                    cancellation: RecommendationsSectionCancellation.load(id),
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
                    cancellation: RecommendationsSectionCancellation.load(id),
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
    static func buildLiveEnvironment(for _: some Store<F>) -> Environment {
        F.Environments.recommendationsSection
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
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
        let environment: RecommendationsSectionMiddleware.Environment

        func task(flowId: AnyHashable) async throws -> any Action {
            guard let movieId else {
                throw CancellationError()
            }
            let movies = try await environment.loadMovies(movieId.value, page)
            return ActionGroup {
                Actions.DidLoadItems(items: movies, id: flowId)
                Actions.DidLoadNestedItems(parentId: movieId, items: movies)
            }
        }
    }
    
    struct LoadShowsEffect: ConcurrencyEffect {
        let showId: Show.ID?
        let page: Int
        let environment: RecommendationsSectionMiddleware.Environment

        func task(flowId: AnyHashable) async throws -> any Action {
            guard let showId else {
                throw CancellationError()
            }
            let shows = try await environment.loadShows(showId.value, page)
            return ActionGroup {
                Actions.DidLoadItems(items: shows, id: flowId)
                Actions.DidLoadNestedItems(parentId: showId, items: shows)
            }
        }
    }
}
