//
//  ItemDetailsMiddleware.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF
import Models

public struct ItemDetailsEnvironment {
    public var loadMovieDetails: (_ movieId: Movie.ID) async throws -> Movie
    public var loadShowDetails: (_ showId: Show.ID) async throws -> Show

    public init(
        loadMovieDetails: @escaping (_ movieId: Movie.ID) async throws -> Movie,
        loadShowDetails: @escaping (_ showId: Show.ID) async throws -> Show
    ) {
        self.loadMovieDetails = loadMovieDetails
        self.loadShowDetails = loadShowDetails
    }
}

enum ItemDetailsCancellation: Hashable {
    case load(ItemDetailsTarget)
}

final class ItemDetailsMiddleware<F: ItemDetailsFeature>: Middleware<F>, @unchecked Sendable {
    public typealias Environment = ItemDetailsEnvironment
    public var environment: Environment!

    public func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.itemDetailsFeatureState.itemDetailsFlow
    }

    public override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    public func observe(state: F) {
        for (id, flow) in state.itemDetailsFeatureState.itemDetailsFlow {
            switch (id, flow) {
            case let (.movie(movieID), .load):
                execute(
                    flowId: ItemDetailsFlow.id,
                    cancellation: ItemDetailsCancellation.load(id),
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
                    cancellation: ItemDetailsCancellation.load(id),
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
    static func buildLiveEnvironment(for _: some Store<F>) -> Environment {
        F.Environments.itemDetails
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        .init(
            loadMovieDetails: { _ in .testItem() },
            loadShowDetails: { _ in .testItem() }
        )
    }
}
