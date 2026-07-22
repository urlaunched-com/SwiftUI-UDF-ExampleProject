//
//  MovieRecommendationsMiddleware.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import API
import UDF
@preconcurrency import Models

enum Cancellation: Hashable {
    case load(RecomendationTarget)
}

public final class RecommendationsSectionMiddleware<F: RecommendationsSectionFeature>: Middleware<F>, @unchecked Sendable {
    public struct Environment {
        var loadMovies: (_ movieId: Int, _ page: Int) async throws -> [Movie]
        var loadShows: (_ showId: Int, _ page: Int) async throws -> [Show]
    }

    public var environment: Environment!

    public func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.recommendationsSectionBindableFlow
    }

    public override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    public func observe(state: F) {
        for (id, flow) in state.recommendationsSectionBindableFlow {
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
                        $0.binded(to: F.RecomendationsSectionContainerType.self, by: id)
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
                        $0.binded(to: F.RecomendationsSectionContainerType.self, by: id)
                    }
                )
            default:
                break
            }
        }
    }
}

// MARK: - Environment build methods

public extension RecommendationsSectionMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> Environment {
        .init(
            loadMovies: { movieId, page in
                try await ItemDetailsAPIClient.loadMovieRecommendations(
                    movieId: movieId,
                    page: page
                )
                .map(\.asMovie)
            },
            loadShows: { showsId, page in
                try await ItemDetailsAPIClient.loadShowRecommendations(
                    showId: showsId,
                    page: page
                ).map(\.asShow)
            }
        )
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
                Actions.DidLoadNestedItems(parentId: movieId, items: movies.ids)
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
                Actions.DidLoadNestedItems(parentId: showId, items: shows.ids)
            }
        }
    }
}

