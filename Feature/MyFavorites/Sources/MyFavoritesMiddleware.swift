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

public struct MyFavoritesEnvironment {
    public var loadMovies: (_ page: Int) async throws -> [Movie]
    public var loadShows: (_ page: Int) async throws -> [Show]

    public init(
        loadMovies: @escaping (_ page: Int) async throws -> [Movie],
        loadShows: @escaping (_ page: Int) async throws -> [Show]
    ) {
        self.loadMovies = loadMovies
        self.loadShows = loadShows
    }
}

public enum MyFavoritesCancellation: Hashable, CaseIterable {
    case loadMovies
    case loadShows
}

final class MyFavoritesMiddleware<F: MyFavoritesFeature>: Middleware<F>, @unchecked Sendable {
    public typealias Environment = MyFavoritesEnvironment
    public var environment: Environment!

    public func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.myFavoritesFeatureState.myFavoritesFlow
    }

    public override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    public func observe(state: F) {
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

extension MyFavoritesMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> Environment {
        F.Environments.myFavorites
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        Environment(
            loadMovies: { _ in Movie.testItems(count: 3) },
            loadShows: { _ in Show.testItems(count: 3) }
        )
    }
}
