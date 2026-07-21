//
//  MyFavoritesMiddleware.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import API
import Foundation
import UDF
@preconcurrency import Models

public enum MyFavoritesCancellation: Hashable, CaseIterable {
    case loadMovies
    case loadShows
}

public final class MyFavoritesMiddleware<F: MyFavoritesFeature>: Middleware<F>, @unchecked Sendable {
    public var environment: Environment!

    public func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.myFavoritesFlow
    }

    public override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    public func observe(state: F) {
        switch state.myFavoritesFlow {
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

    public struct Environment {
        var loadMovies: (_ page: Int) async throws -> [Movie]
        var loadShows: (_ page: Int) async throws -> [Show]
    }
}

public extension MyFavoritesMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> Environment {
        Environment(
            loadMovies: { page in
                let movies = try await HomeAPIClient.loadMovies(
                    section: MovieSection.nowPlaying.urlValue,
                    page: page
                )
                return movies.map(\.asMovie)
            },
            loadShows: { page in
                let shows = try await HomeAPIClient.loadShows(
                    section: ShowSection.popular.urlValue,
                    page: page
                )
                return shows.map(\.asShow)
            }
        )
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        Environment(
            loadMovies: { _ in Movie.testItems(count: 3) },
            loadShows: { _ in Show.testItems(count: 3) }
        )
    }
}
