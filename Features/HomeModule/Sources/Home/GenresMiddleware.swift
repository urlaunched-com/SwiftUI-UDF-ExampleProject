//
//  GenresMiddleware.swift
//  Flick
//
//  Created by Alexander Sharko on 15.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import Foundation
import UDF
import Models
import SwiftFoundation

public struct GenresEnvironment {
    public var loadMovieGenres: () async throws -> [Genre]
    public var loadShowGenres: () async throws -> [Genre]

    public init(
        loadMovieGenres: @escaping () async throws -> [Genre],
        loadShowGenres: @escaping () async throws -> [Genre]
    ) {
        self.loadMovieGenres = loadMovieGenres
        self.loadShowGenres = loadShowGenres
    }
}

public enum HomeGenresCancellation: Hashable {
    case loadMovieGenres
    case loadShowGenres
}

final class GenresMiddleware<F: HomeFeature>: Middleware<F>, @unchecked Sendable {
    public typealias Environment = GenresEnvironment
    public var environment: Environment!

    public func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.homeFeatureState.movieGenresFlow
        state.homeFeatureState.showGenresFlow
    }

    public override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    public func observe(state: F) {
        print("observe(state: F)")
        if state.homeFeatureState.movieGenresFlow.isLoading {
            execute(flowId: MovieGenresFlow.id, cancellation: HomeGenresCancellation.loadMovieGenres) { [unowned self] taskId in
                let data = try await self.environment.loadMovieGenres()
                return Actions.DidLoadItems(items: data, id: taskId)
            }
        }

        if state.homeFeatureState.showGenresFlow.isLoading {
            execute(flowId: ShowGenresFlow.id, cancellation: HomeGenresCancellation.loadShowGenres) { [unowned self] taskId in
                let data = try await self.environment.loadShowGenres()
                return Actions.DidLoadItems(items: data, id: taskId)
            }
        }
    }
}

extension GenresMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> Environment {
        F.Environments.genres
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        Environment(
            loadMovieGenres: { Genre.fakeItems() },
            loadShowGenres: { Genre.fakeItems() }
        )
    }
}
