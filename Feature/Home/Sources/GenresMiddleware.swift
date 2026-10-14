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

enum HomeGenresCancellation: Hashable {
    case loadMovieGenres
    case loadShowGenres
}

final class GenresMiddleware<F: HomeFeature>: Middleware<F>, @unchecked Sendable {
    var environment: Environment!

    func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.homeFeatureState.movieGenresFlow
        state.homeFeatureState.showGenresFlow
    }

    override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func observe(state: F) {
        print("observe(state: F)")
        if state.homeFeatureState.movieGenresFlow.isLoading {
            execute(flowId: MovieGenresFlow.id, cancellation: HomeGenresCancellation.loadMovieGenres) { [unowned self] taskId in
                let data = try await self.environment.loadMovieGenres()
                return Actions.DidLoadItems(items: data, id: taskId)
            }
        }

        if state.homeFeatureState.showGenresFlow.isLoading {
            execute(flowId: ShowGenresFlow.id, cancellation: HomeGenresCancellation.loadShowGenres) { [unowned self] taskId in
                let data = try await self.environment.loadShowGenres()
                return Actions.DidLoadItems(items: data, id: taskId)
            }
        }
    }

    struct Environment {
        var loadMovieGenres: () async throws -> [Genre]
        var loadShowGenres: () async throws -> [Genre]
    }
}

extension GenresMiddleware {
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
