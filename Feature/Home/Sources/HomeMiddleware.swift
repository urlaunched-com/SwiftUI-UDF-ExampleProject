//
//  HomeMiddleware.swift
//  Flick
//
//  Created by Alexander Sharko on 01.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import Foundation
import UDF
import SectionsModels
import MediaModels
import Models

enum HomeCancellation: Hashable {
    case loadMovies(MovieSection)
    case loadShows(ShowSection)
}

final class HomeMiddleware<F: HomeFeature>: Middleware<F>, @unchecked Sendable {
    var environment: HomeEnvironment!

    override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func reduce(_ action: some Action, for _: F) {
        switch action {
        case let action as Actions.LoadHomeSection where action.sectionId.base is MovieSection:
            guard let section = action.sectionId.base as? MovieSection else {
                return
            }
            execute(flowId: HomeFlow.id, cancellation: HomeCancellation.loadMovies(section)) { [unowned self] taskId in
                let data = try await environment.loadMovies(section)
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
                let data = try await environment.loadShows(section)
                return ActionGroup {
                    Actions.DidLoadItems(items: data, id: taskId)
                    Actions.DidLoadNestedItems(parentId: section, items: data.map(\.id), id: taskId)
                }
            }

        default:
            break
        }
    }
}

// MARK: - Environment build methods

extension HomeMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> HomeEnvironment {
        F.HomeEnvironment.homeEnvironment
    }

    static func buildTestEnvironment(for _: some Store) -> HomeEnvironment {
        HomeEnvironment(
            loadMovies: { _ in Movie.fakeItems() },
            loadShows: { _ in Show.fakeItems() }
        )
    }
}
