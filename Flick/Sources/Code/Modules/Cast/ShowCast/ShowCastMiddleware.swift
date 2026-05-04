//
//  ShowCastMiddleware.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import API
import UDF

final class ShowCastMiddleware: BaseObservableMiddleware<AppState> {
    enum Cancellation: Hashable {
        case loadShowCast(Show.ID)
    }

    struct Environment {
        var loadShowCast: (_ showId: Int) async throws -> [Cast]
    }

    var environment: Environment!

    func scope(for state: AppState) -> Scope {
        state.networkConnectivityForm
        state.showCastFlow
    }

    override func status(for state: AppState) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func observe(state: AppState) {
        for (id, flow) in state.showCastFlow {
            switch flow {
            case let .loadShowCast(showId):
                execute(
                    flowId: ShowCastFlow.id,
                    cancellation: Cancellation.loadShowCast(id),
                    mapAction: {
                        $0.binded(to: state.showCastFlow.containerType, by: id)
                    }
                ) { [unowned self] taskId in
                    let cast = try await self.environment.loadShowCast(showId.value)
                    return ActionGroup {
                        Actions.DidLoadItems(items: cast, id: taskId)
                        Actions.DidLoadNestedItems(parentId: showId, items: cast.ids)
                    }
                }

            default:
                break
            }
        }
    }
}

// MARK: - Environment build methods

extension ShowCastMiddleware {
    static func buildLiveEnvironment(for _: some Store<AppState>) -> Environment {
        .init(
            loadShowCast: { showId in
                try await ItemDetailsAPIClient.loadShowCast(showId: showId).map(\.asCast)
            }
        )
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        .init(
            loadShowCast: { _ in Cast.testItems(count: 3) }
        )
    }
}
