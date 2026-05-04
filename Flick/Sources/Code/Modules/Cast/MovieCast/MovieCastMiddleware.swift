//
//  MovieCastMiddleware.swift
//  Flick
//
//  Created by Valentin Petrulia on 13.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import API
import UDF

final class MovieCastMiddleware: BaseObservableMiddleware<AppState> {
    enum Cancellation: Hashable {
        case loadMovieCast(Movie.ID)
    }

    struct Environment {
        var loadMovieCast: (_ movieId: Int) async throws -> [Cast]
    }

    var environment: Environment!

    func scope(for state: AppState) -> Scope {
        state.networkConnectivityForm
        state.movieCastFlow
    }

    override func status(for state: AppState) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func observe(state: AppState) {
        for (id, flow) in state.movieCastFlow {
            switch flow {
            case let .loadMovieCast(movieId):
                execute(
                    flowId: MovieCastFlow.id,
                    cancellation: Cancellation.loadMovieCast(id),
                    mapAction: {
                        $0.binded(to: state.movieCastFlow.containerType, by: id)
                    }
                ) { [unowned self] taskId in
                    let cast = try await self.environment.loadMovieCast(movieId.value)
                    return ActionGroup {
                        Actions.DidLoadItems(items: cast, id: taskId)
                        Actions.DidLoadNestedItems(parentId: movieId, items: cast.ids)
                    }
                }

            default:
                break
            }
        }
    }
}

// MARK: - Environment build methods

extension MovieCastMiddleware {
    static func buildLiveEnvironment(for _: some Store<AppState>) -> Environment {
        .init(
            loadMovieCast: { movieId in
                try await ItemDetailsAPIClient.loadMovieCast(movieId: movieId).map(\.asCast)
            }
        )
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        .init(
            loadMovieCast: { _ in Cast.testItems(count: 3) }
        )
    }
}
