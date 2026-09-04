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
import Models

public enum HomeGenresCancellation: Hashable {
    case loadMovieGenres
    case loadShowGenres
}

public final class GenresMiddleware<F: HomeFeature>: Middleware<F>, @unchecked Sendable {
    public var environment: Environment!

    public func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.movieGenresFlow
        state.showGenresFlow
    }

    public override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    public func observe(state: F) {
        if state.movieGenresFlow.isLoading {
            execute(flowId: MovieGenresFlow.id, cancellation: HomeGenresCancellation.loadMovieGenres) { [unowned self] taskId in
                let data = try await self.environment.loadMovieGenres()
                return Actions.DidLoadItems(items: data, id: taskId)
            }
        }

        if state.showGenresFlow.isLoading {
            execute(flowId: ShowGenresFlow.id, cancellation: HomeGenresCancellation.loadShowGenres) { [unowned self] taskId in
                let data = try await self.environment.loadShowGenres()
                return Actions.DidLoadItems(items: data, id: taskId)
            }
        }
    }

    public struct Environment {
        var loadMovieGenres: () async throws -> [Genre]
        var loadShowGenres: () async throws -> [Genre]
    }
}

public extension GenresMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> Environment {
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
