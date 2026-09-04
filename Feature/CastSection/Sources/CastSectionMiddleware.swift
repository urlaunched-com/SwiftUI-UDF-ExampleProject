//
//  CastSectionMiddleware.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import API
import UDF
@preconcurrency import Models

public enum CastSectionCancellation: Hashable {
    case loadMovieCast(Movie.ID)
    case loadShowCast(Show.ID)
}

public final class CastSectionMiddleware<F: CastSectionFeature>: Middleware<F>, @unchecked Sendable {
    public struct Environment: @unchecked Sendable {
        var loadMovieCast: (_ movieId: Int) async throws -> [Cast]
        var loadShowCast: (_ showId: Int) async throws -> [Cast]
    }

    public var environment: Environment!

    public func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.castSectionBindableFlow
    }

    public override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    public func observe(state: F) {
        for (id, flow) in state.castSectionBindableFlow {
            switch (id, flow) {
            case let (.movie(movieId), .loadMovieCast(targetId)) where movieId == targetId:
                execute(
                    flowId: CastSectionFlow.id,
                    cancellation: CastSectionCancellation.loadMovieCast(movieId),
                    mapAction: {
                        $0.binded(to: F.CastSectionContainerType.self, by: id)
                    }
                ) { [unowned self] taskId in
                    let cast = try await self.environment.loadMovieCast(movieId.value)
                    return ActionGroup {
                        Actions.DidLoadItems(items: cast, id: taskId)
                        Actions.DidLoadNestedItems(parentId: movieId, items: cast.ids)
                    }
                }

            case let (.show(showId), .loadShowCast(targetId)) where showId == targetId:
                execute(
                    flowId: CastSectionFlow.id,
                    cancellation: CastSectionCancellation.loadShowCast(showId),
                    mapAction: {
                        $0.binded(to: F.CastSectionContainerType.self, by: id)
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

public extension CastSectionMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> Environment {
        .init(
            loadMovieCast: { movieId in
                try await ItemDetailsAPIClient.loadMovieCast(movieId: movieId).map(\.asCast)
            },
            loadShowCast: { showId in
                try await ItemDetailsAPIClient.loadShowCast(showId: showId).map(\.asCast)
            }
        )
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        .init(
            loadMovieCast: { _ in Cast.testItems(count: 3) },
            loadShowCast: { _ in Cast.testItems(count: 3) }
        )
    }
}
