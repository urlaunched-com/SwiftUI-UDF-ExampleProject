//
//  GenresMiddleware.swift
//  Flick
//
//  Created by Alexander Sharko on 15.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import API
import Foundation
import UDF

final class GenresMiddleware: BaseObservableMiddleware<AppState> {
    var environment: Environment!

    func scope(for state: AppState) -> Scope {
        state.networkConnectivityForm
        state.movieGenresFlow
        state.showGenresFlow
    }

    override func status(for state: AppState) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func observe(state: AppState) {
        switch state.movieGenresFlow {
        case .loading:
            execute(flowId: MovieGenresFlow.id, cancellation: Cancellation.loadMovieGenres) { [unowned self] taskId in
                let data = try await self.environment.loadMovieGenres()
                return Actions.DidLoadItems(items: data, id: taskId)
            }

        default:
            break
        }

        switch state.showGenresFlow {
        case .loading:
            execute(flowId: ShowGenresFlow.id, cancellation: Cancellation.loadShowGenres) { [unowned self] taskId in
                let data = try await self.environment.loadShowGenres()
                return Actions.DidLoadItems(items: data, id: taskId)
            }

        default:
            break
        }
    }

    struct Environment {
        var loadMovieGenres: () async throws -> [Genre]
        var loadShowGenres: () async throws -> [Genre]
    }

    enum Cancellation: Hashable {
        case loadMovieGenres
        case loadShowGenres
    }
}

// MARK: - Environment buid methods

extension GenresMiddleware {
    static func buildLiveEnvironment(for _: some Store) -> Environment {
        Environment(
            loadMovieGenres: {
                let movieGenres = try await HomeAPIClient.loadMovieGenres()
                return movieGenres.map(\.asGenre)
            },
            loadShowGenres: {
                let showGenres = try await HomeAPIClient.loadShowGenres()
                return showGenres.map(\.asGenre)
            }
        )
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        Environment(
            loadMovieGenres: { Genre.fakeItems() },
            loadShowGenres: { Genre.fakeItems() }
        )
    }
}
