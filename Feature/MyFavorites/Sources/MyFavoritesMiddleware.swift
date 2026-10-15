//
//  MyFavoritesMiddleware.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Foundation
import UDF
@preconcurrency import Models

enum MyFavoritesCancellation: Hashable, CaseIterable {
    case loadMovies
    case loadShows
}

final class MyFavoritesMiddleware<F: MyFavoritesFeature>: Middleware<F>, @unchecked Sendable {
    var environment: MyFavoritesEnvironment!

    func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.myFavoritesFeatureState.myFavoritesFlow
    }

    override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func observe(state: F) {
        switch state.myFavoritesFeatureState.myFavoritesFlow {
        case let .loadMovies(page):
            execute(
                flowId: MyFavoritesFlow.loadMoviesId,
                cancellation: MyFavoritesCancellation.loadMovies
            ) { [unowned self] taskId in
                let movies = try await self.environment.loadMovies(page)
                return Actions.DidLoadItems(items: movies, id: taskId)
            }

        case let .loadShows(page):
            execute(
                flowId: MyFavoritesFlow.loadShowsId,
                cancellation: MyFavoritesCancellation.loadShows
            ) { [unowned self] taskId in
                let shows = try await self.environment.loadShows(page)
                return Actions.DidLoadItems(items: shows, id: taskId)
            }

        default:
            break
        }
    }
}

// MARK: - Environment build methods

extension MyFavoritesMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> MyFavoritesEnvironment {
        F.MyFavoritesEnvironment.myFavoritesEnvironment
    }

    static func buildTestEnvironment(for _: some Store) -> MyFavoritesEnvironment {
        MyFavoritesEnvironment(
            loadMovies: { _ in Movie.testItems(count: 3) },
            loadShows: { _ in Show.testItems(count: 3) }
        )
    }
}
