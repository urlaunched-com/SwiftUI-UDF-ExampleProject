//
//  CastSectionMiddleware.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
@preconcurrency import Models

public struct CastSectionEnvironment: @unchecked Sendable {
    public var loadMovieCast: (_ movieId: Int) async throws -> [Cast]
    public var loadShowCast: (_ showId: Int) async throws -> [Cast]

    public init(
        loadMovieCast: @escaping (_ movieId: Int) async throws -> [Cast],
        loadShowCast: @escaping (_ showId: Int) async throws -> [Cast]
    ) {
        self.loadMovieCast = loadMovieCast
        self.loadShowCast = loadShowCast
    }
}

public enum CastSectionCancellation: Hashable {
    case loadMovieCast(Movie.ID)
    case loadShowCast(Show.ID)
}

final class CastSectionMiddleware<F: ItemDetailsFeature>: Middleware<F>, @unchecked Sendable {

    public typealias Environment = CastSectionEnvironment
    public var environment: Environment!

    public func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.itemDetailsFeatureState.castSectionFlow
    }

    public override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    public func observe(state: F) {
        for (id, flow) in state.itemDetailsFeatureState.castSectionFlow {
            switch (id, flow) {
            case let (.movie(movieId), .loadMovieCast(targetId)) where movieId == targetId:
                execute(
                    flowId: CastSectionFlow.id,
                    cancellation: CastSectionCancellation.loadMovieCast(movieId),
                    mapAction: {
                        $0.binded(to: CastSectionContainer<F>.self, by: id)
                    }
                ) { [unowned self] taskId in
                    let cast = try await self.environment.loadMovieCast(movieId.value)
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
                    let cast = try await self.environment.loadShowCast(showId.value)
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

extension CastSectionMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> Environment {
        F.Environments.castSection
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        .init(
            loadMovieCast: { _ in Cast.testItems(count: 3) },
            loadShowCast: { _ in Cast.testItems(count: 3) }
        )
    }
}
