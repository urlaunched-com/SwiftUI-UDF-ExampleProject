//
//  MovieRecommendationsMiddleware.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import API
import UDF

final class MovieRecommendationsMiddleware: BaseObservableMiddleware<AppState> {
    enum Cancellation: Hashable {
        case loadMovies(Movie.ID)
    }

    struct Environment {
        var loadMovies: (_ movieId: Int, _ page: Int) async throws -> [Movie]
    }

    var environment: Environment!

    func scope(for state: AppState) -> Scope {
        state.networkConnectivityForm
        state.movieRecommendationsFlow
        state.movieDetailsRecommendationsFlow
    }

    override func status(for state: AppState) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func observe(state: AppState) {
        for (id, flow) in state.movieRecommendationsFlow {
            switch flow {
            case let .loadMovies(page):
                execute(
                    effect: LoadMoviesEffect(
                        movieId: id,
                        page: page,
                        environment: environment
                    ),
                    flowId: MovieRecommendationsFlow.id,
                    cancellation: Cancellation.loadMovies(id),
                    mapAction: {
                        $0.binded(to: state.movieRecommendationsFlow.containerType, by: id)
                    }
                )

            default:
                break
            }
        }

        for (id, flow) in state.movieDetailsRecommendationsFlow {
            switch flow {
            case let .loadMovies(page):
                execute(
                    effect: LoadMoviesEffect(
                        movieId: id,
                        page: page,
                        environment: environment
                    ),
                    flowId: MovieRecommendationsFlow.id,
                    cancellation: Cancellation.loadMovies(id),
                    mapAction: {
                        $0.binded(to: state.movieDetailsRecommendationsFlow.containerType, by: id)
                    }
                )

            default:
                break
            }
        }
    }
}

// MARK: - Environment build methods

extension MovieRecommendationsMiddleware {
    static func buildLiveEnvironment(for _: some Store<AppState>) -> Environment {
        .init(
            loadMovies: { movieId, page in
                try await ItemDetailsAPIClient.loadMovieRecommendations(
                    movieId: movieId,
                    page: page
                )
                .map(\.asMovie)
            }
        )
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        .init(
            loadMovies: { _, _ in Movie.testItems(count: 3) }
        )
    }
}

// MARK: - Effects

private extension MovieRecommendationsMiddleware {
    struct LoadMoviesEffect: ConcurrencyEffect {
        let movieId: Movie.ID?
        let page: Int
        let environment: MovieRecommendationsMiddleware.Environment

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
}
