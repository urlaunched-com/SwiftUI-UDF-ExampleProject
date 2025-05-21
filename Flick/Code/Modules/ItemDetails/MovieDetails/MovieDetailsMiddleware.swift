//
//  MovieDetailsMiddleware.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import API
import UDF

final class MovieDetailsMiddleware: BaseObservableMiddleware<AppState> {
    enum Cancellation: Hashable {
        case loadMovie(Movie.ID)
    }

    var environment: Environment!

    struct Environment {
        var loadMovieDetails: (_ movieId: Int) async throws -> Movie
    }

    func scope(for state: AppState) -> Scope {
        state.networkConnectivityForm
        state.movieDetailsFlow
    }

    override func status(for state: AppState) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func observe(state: AppState) {
        for (id, flow) in state.movieDetailsFlow {
            switch flow {
            case let .loadMovie(movieId):
                execute(
                    flowId: MovieDetailsFlow.id,
                    cancellation: Cancellation.loadMovie(id),
                    mapAction: {
                        $0.binded(to: state.movieDetailsFlow.containerType, by: id)
                    }
                ) { [unowned self] taskId in
                    let movie = try await self.environment.loadMovieDetails(movieId.value)
                    return Actions.DidLoadItem(item: movie, id: taskId)
                }

            default:
                break
            }
        }
    }
}

// MARK: - Environment build methods

extension MovieDetailsMiddleware {
    static func buildLiveEnvironment(for _: some Store<AppState>) -> Environment {
        .init(
            loadMovieDetails: { movieId in
                try await ItemDetailsAPIClient.loadMovie(movieId: movieId).asMovie
            }
        )
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        .init(
            loadMovieDetails: { _ in .testItem() }
        )
    }
}
