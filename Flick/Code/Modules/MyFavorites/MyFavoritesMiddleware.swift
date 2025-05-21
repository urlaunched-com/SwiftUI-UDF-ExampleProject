//
//  MyFavoritesMiddleware.swift
//  Flick
//
//  Created by Vlad Andrieiev on 24.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import API
import Foundation
import UDF

final class MyFavoritesMiddleware: BaseObservableMiddleware<AppState> {
    enum Cancellation: Hashable, CaseIterable {
        case loadMovies, loadShows
    }

    struct Environment {
        var loadMovies: (_ page: Int) async throws -> [Movie]
        var loadShows: (_ page: Int) async throws -> [Show]
    }

    var environment: Environment!

    func scope(for state: AppState) -> Scope {
        state.networkConnectivityForm
        state.myFavoritesFlow
    }

    override func status(for state: AppState) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func observe(state: AppState) {
        switch state.myFavoritesFlow {
        case let .loadMovies(page):
            execute(flowId: MyFavoritesFlow.loadMoviesId, cancellation: Cancellation.loadMovies) { [self] id in
                let movies = try await self.environment.loadMovies(page)
                return Actions.DidLoadItems(items: movies, id: id)
            }

        case let .loadShows(page):
            execute(flowId: MyFavoritesFlow.loadShowsId, cancellation: Cancellation.loadShows) { [self] id in
                let shows = try await self.environment.loadShows(page)
                return Actions.DidLoadItems(items: shows, id: id)
            }

        default:
            break
        }
    }
}

// MARK: - Environment buid methods

extension MyFavoritesMiddleware {
    static func buildLiveEnvironment(for _: some Store<AppState>) -> Environment {
        Environment(
            loadMovies: { page in
                let movies = try await HomeAPIClient.loadMovies(section: MovieSection.nowPlaying.urlValue, page: page)
                return movies.map(\.asMovie)
            },
            loadShows: { page in
                let showes = try await HomeAPIClient.loadShows(section: ShowSection.popular.urlValue, page: page)
                return showes.map(\.asShow)
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
