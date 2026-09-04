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
import Models

public enum HomeCancellation: Hashable {
    case loadMovies(MovieSection)
    case loadShows(ShowSection)
}

public final class HomeMiddleware<F: HomeFeature>: Middleware<F>, @unchecked Sendable {
    public var environment: Environment!

    public override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    public func reduce(_ action: some Action, for _: F) {
        switch action {
        case let action as Actions.LoadHomeSection where action.sectionId.base is MovieSection:
            guard let section = action.sectionId.base as? MovieSection else {
                return
            }
            execute(flowId: HomeFlow.id, cancellation: HomeCancellation.loadMovies(section)) { [unowned self] taskId in
                let data = try await environment.loadMovies(section.urlValue)
                return ActionGroup {
                    Actions.DidLoadItems(items: data, id: taskId)
                    Actions.DidLoadNestedItems(parentId: section, items: data.map(\.id), id: taskId)
                }
            }

        case let action as Actions.LoadHomeSection where action.sectionId.base is ShowSection:
            guard let section = action.sectionId.base as? ShowSection else {
                return
            }
            execute(flowId: HomeFlow.id, cancellation: HomeCancellation.loadShows(section)) { [unowned self] taskId in
                let data = try await environment.loadShows(section.urlValue)
                return ActionGroup {
                    Actions.DidLoadItems(items: data, id: taskId)
                    Actions.DidLoadNestedItems(parentId: section, items: data.map(\.id), id: taskId)
                }
            }

        default:
            break
        }
    }

    public struct Environment {
        var loadMovies: (_ section: String) async throws -> [Movie]
        var loadShows: (_ section: String) async throws -> [Show]
    }
}

public extension HomeMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> Environment {
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
