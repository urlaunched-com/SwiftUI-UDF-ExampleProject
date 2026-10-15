//
//  ItemDetailsMiddleware.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF
import Models

enum Cancellation: Hashable {
    case load(ItemDetailsTarget)
}

final class ItemDetailsMiddleware<F: ItemDetailsFeature>: Middleware<F>, @unchecked Sendable {
    var environment: ItemDetailsEnvironment!

    func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.itemDetailsFeatureState.itemDetailsFlow
    }

    override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func observe(state: F) {
        for (id, flow) in state.itemDetailsFeatureState.itemDetailsFlow {
            switch (id, flow) {
            case let (.movie(movieID), .load):
                execute(
                    flowId: ItemDetailsFlow.id,
                    cancellation: Cancellation.load(id),
                    mapAction: {
                        $0.binded(to: ItemDetailsContainer<F>.self, by: id)
                    }
                ) { [unowned self] taskId in
                    let movie = try await self.environment.loadMovieDetails(movieID)
                    return Actions.DidLoadItem(item: movie, id: taskId)
                }

            case let (.show(showID), .load):
                execute(
                    flowId: ItemDetailsFlow.id,
                    cancellation: Cancellation.load(id),
                    mapAction: {
                        $0.binded(to: ItemDetailsContainer<F>.self, by: id)
                    }
                ) { [unowned self] taskId in
                    let show = try await self.environment.loadShowDetails(showID)
                    return Actions.DidLoadItem(item: show, id: taskId)
                }
            default:
                break
            }
        }
    }
}

// MARK: - Environment build methods
extension ItemDetailsMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> ItemDetailsEnvironment {
        F.ItemDetailsEnvironment.itemDetailsEnvironment
    }

    static func buildTestEnvironment(for _: some Store) -> ItemDetailsEnvironment {
        .init(
            loadMovieDetails: { _ in .testItem() },
            loadShowDetails: { _ in .testItem() }
        )
    }
}
