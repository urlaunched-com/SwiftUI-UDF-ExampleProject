//
//  HomeMiddleware.swift
//  Flick
//
//  Created by Alexander Sharko on 01.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import API
import Foundation
import UDF

final class HomeMiddleware: BaseReducibleMiddleware<AppState> {
    var environment: Environment!

    struct Environment {
        var loadMovies: (_ section: String) async throws -> [Movie]
        var loadShows: (_ section: String) async throws -> [Show]
    }

    enum Cancellation: Hashable {
        case loadMovies(MovieSection)
        case loadShows(ShowSection)
    }

    override func status(for state: AppState) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func reduce(_ action: some Action, for _: AppState) {
        switch action {
        case let action as Actions.LoadHomeSection<MovieSection>:
            execute(flowId: HomeFlow.id, cancellation: Cancellation.loadMovies(action.sectionId)) { [unowned self] taskId in
                let data = try await environment.loadMovies(action.sectionId.urlValue)
                return ActionGroup {
                    Actions.DidLoadItems(items: data, id: taskId)
                    Actions.DidLoadNestedItems(parentId: action.sectionId, items: data.map(\.id), id: taskId)
                }
            }

        case let action as Actions.LoadHomeSection<ShowSection>:
            execute(flowId: HomeFlow.id, cancellation: Cancellation.loadShows(action.sectionId)) { [unowned self] taskId in
                let data = try await environment.loadShows(action.sectionId.urlValue)
                return ActionGroup {
                    Actions.DidLoadItems(items: data, id: taskId)
                    Actions.DidLoadNestedItems(parentId: action.sectionId, items: data.map(\.id), id: taskId)
                }
            }

        default: break
        }
    }
}

// MARK: - Environment buid methods

extension HomeMiddleware {
    static func buildLiveEnvironment(for _: some Store<AppState>) -> Environment {
        Environment(
            loadMovies: {
                let movies = try await HomeAPIClient.loadMovies(section: $0)
                return movies.map(\.asMovie)
            },
            loadShows: {
                let shows = try await HomeAPIClient.loadShows(section: $0)
                return shows.map(\.asShow)
            }
        )
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        Environment(
            loadMovies: { _ in Movie.fakeItems() },
            loadShows: { _ in Show.fakeItems() }
        )
    }
}
