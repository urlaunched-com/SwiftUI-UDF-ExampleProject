//
//  ItemDetailsMiddleware.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import API
import UDF
import Models

enum Cancellation: Hashable {
    case load(ItemDetailsTarget)
}

public final class ItemDetailsMiddleware<F: ItemDetailsFeature>: Middleware<F>, @unchecked Sendable {

    public var environment: Environment!

    public struct Environment {
        var loadMovieDetails: (_ movieId: Int) async throws -> Movie
        var loadShowDetails: (_ showId: Int) async throws -> Show
    }

    public func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.itemDetailsBindableFlow
    }

    public override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    public func observe(state: F) {
        for (id, flow) in state.itemDetailsBindableFlow {
            switch (id, flow) {
            case let (.movie(movieID), .load):
                execute(
                    flowId: ItemDetailsFlow.id,
                    cancellation: Cancellation.load(id),
                    mapAction: {
                        $0.binded(to: F.ItemDetailsContainerType.self, by: id)
                    }
                ) { [unowned self] taskId in
                    let movie = try await self.environment.loadMovieDetails(movieID.value)
                    return Actions.DidLoadItem(item: movie, id: taskId)
                }

            case let (.show(showID), .load):
                execute(
                    flowId: ItemDetailsFlow.id,
                    cancellation: Cancellation.load(id),
                    mapAction: {
                        $0.binded(to: F.ItemDetailsContainerType.self, by: id)
                    }
                ) { [unowned self] taskId in
                    let show = try await self.environment.loadShowDetails(showID.value)
                    return Actions.DidLoadItem(item: show, id: taskId)
                }
            default:
                break
            }
        }
    }
}

// MARK: - Environment build methods
public extension ItemDetailsMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> Environment {
        .init(
            loadMovieDetails: { movieId in
                try await ItemDetailsAPIClient.loadMovie(movieId: movieId).asMovie
            },
            loadShowDetails: { showId in
                try await ItemDetailsAPIClient.loadShow(showId: showId).asShow
            }
        )
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        .init(
            loadMovieDetails: { _ in .testItem() },
            loadShowDetails: { _ in .testItem() }
        )
    }
}
