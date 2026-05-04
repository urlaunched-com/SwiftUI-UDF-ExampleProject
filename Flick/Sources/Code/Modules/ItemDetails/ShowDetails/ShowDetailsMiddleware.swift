//
//  ShowDetailsMiddleware.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import API
import UDF

final class ShowDetailsMiddleware: BaseObservableMiddleware<AppState> {
    enum Cancellation: Hashable {
        case loadShow(Show.ID)
    }

    var environment: Environment!

    struct Environment {
        var loadShowDetails: (_ showId: Int) async throws -> Show
    }

    func scope(for state: AppState) -> Scope {
        state.networkConnectivityForm
        state.showDetailsFlow
    }

    override func status(for state: AppState) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func observe(state: AppState) {
        for (id, flow) in state.showDetailsFlow {
            switch flow {
            case let .loadShow(showId):
                execute(
                    flowId: MovieDetailsFlow.id,
                    cancellation: Cancellation.loadShow(id),
                    mapAction: {
                        $0.binded(to: state.showDetailsFlow.containerType, by: id)
                    }
                ) { [unowned self] taskId in
                    let show = try await self.environment.loadShowDetails(showId.value)
                    return Actions.DidLoadItem(item: show, id: taskId)
                }

            default:
                break
            }
        }
    }
}

// MARK: - Environment build methods

extension ShowDetailsMiddleware {
    static func buildLiveEnvironment(for _: some Store<AppState>) -> Environment {
        .init(
            loadShowDetails: { showId in
                try await ItemDetailsAPIClient.loadShow(showId: showId).asShow
            }
        )
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        .init(
            loadShowDetails: { _ in .testItem() }
        )
    }
}
