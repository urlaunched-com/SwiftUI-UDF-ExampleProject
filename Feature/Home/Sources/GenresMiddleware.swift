//
//  GenresMiddleware.swift
//  Flick
//
//  Created by Alexander Sharko on 15.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import Foundation
import UDF
import MediaModels

enum HomeGenresCancellation: Hashable {
    case loadMovieGenres
    case loadShowGenres
}

final class GenresMiddleware<F: HomeFeature>: Middleware<F>, @unchecked Sendable {
    var environment: HomeGenresEnvironment!

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
}

// MARK: - Environment build methods

extension GenresMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> HomeGenresEnvironment {
        F.HomeEnvironment.homeGenresEnvironment
    }

    static func buildTestEnvironment(for _: some Store) -> HomeGenresEnvironment {
        HomeGenresEnvironment(
            loadMovieGenres: { Genre.fakeItems() },
            loadShowGenres: { Genre.fakeItems() }
        )
    }
}
