//
//  CastSectionMiddleware.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
@preconcurrency import CastModels
@preconcurrency import MediaModels

enum CastSectionCancellation: Hashable {
    case loadMovieCast(Movie.ID)
    case loadShowCast(Show.ID)
}

final class CastSectionMiddleware<F: CastSectionFeature>: Middleware<F>, @unchecked Sendable {
    var environment: CastSectionEnvironment!

    func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.castSectionFeatureState.castSectionFlow
    }

    override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func observe(state: F) {
        for (id, flow) in state.castSectionFeatureState.castSectionFlow {
            switch (id, flow) {
            case let (.movie(movieId), .loadMovieCast(targetId)) where movieId == targetId:
                execute(
                    flowId: CastSectionFlow.id,
                    cancellation: CastSectionCancellation.loadMovieCast(movieId),
                    mapAction: {
                        $0.binded(to: CastSectionContainer<F>.self, by: id)
                    }
                ) { [unowned self] taskId in
                    let cast = try await self.environment.loadMovieCast(movieId)
                    return ActionGroup {
                        Actions.DidLoadItems(items: cast, id: taskId)
                        Actions.DidLoadNestedItems(parentId: movieId, items: cast)
                    }
                }

            case let (.show(showId), .loadShowCast(targetId)) where showId == targetId:
                execute(
                    flowId: CastSectionFlow.id,
                    cancellation: CastSectionCancellation.loadShowCast(showId),
                    mapAction: {
                        $0.binded(to: CastSectionContainer<F>.self, by: id)
                    }
                ) { [unowned self] taskId in
                    let cast = try await self.environment.loadShowCast(showId)
                    return ActionGroup {
                        Actions.DidLoadItems(items: cast, id: taskId)
                        Actions.DidLoadNestedItems(parentId: showId, items: cast)
                    }
                }

            default:
                break
            }
        }
    }
}

// MARK: - Environment build methods

extension CastSectionMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> CastSectionEnvironment {
        F.CastSectionEnvironment.castSectionEnvironment
    }

    static func buildTestEnvironment(for _: some Store) -> CastSectionEnvironment {
        .init(
            loadMovieCast: { _ in Cast.testItems(count: 3) },
            loadShowCast: { _ in Cast.testItems(count: 3) }
        )
    }
}
