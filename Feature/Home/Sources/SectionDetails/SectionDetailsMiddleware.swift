//
//  SectionDetailsMiddleware.swift
//  Flick
//
//  Created by Alexander Sharko on 06.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Foundation
import UDF
@preconcurrency import Models

public struct SectionDetailsEnvironment {
    public var loadMovies: (_ section: MovieSection.ID, _ page: Int) async throws -> [Movie]
    public var loadShows: (_ section: ShowSection.ID, _ page: Int) async throws -> [Show]

    public init(
        loadMovies: @escaping (_ section: MovieSection.ID, _ page: Int) async throws -> [Movie],
        loadShows: @escaping (_ section: ShowSection.ID, _ page: Int) async throws -> [Show]
    ) {
        self.loadMovies = loadMovies
        self.loadShows = loadShows
    }
}

enum SectionDetailsCancellation: Hashable, CaseIterable {
    case loadMovies
    case loadShows
}

final class SectionDetailsMiddleware<F: HomeFeature>: Middleware<F>, @unchecked Sendable {

    public typealias Environment = SectionDetailsEnvironment
    public var environment: Environment!

    public func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.homeFeatureState.sectionDetailsFlow
    }

    public override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    public func observe(state: F) {
        switch state.homeFeatureState.sectionDetailsFlow {
        case let .loadMovies(page):
            execute(
                effect: LoadMoviesEffect(
                    sectionId: state.homeFeatureState.sectionDetailsForm.movieSectionId,
                    page: page,
                    environment: environment
                ),
                flowId: SectionDetailsFlow.loadMoviesId,
                cancellation: SectionDetailsCancellation.loadMovies
            )

        case let .loadShows(page):
            execute(
                effect: LoadShowsEffect(
                    sectionId: state.homeFeatureState.sectionDetailsForm.showSectionId,
                    page: page,
                    environment: environment
                ),
                flowId: SectionDetailsFlow.loadShowsId,
                cancellation: SectionDetailsCancellation.loadShows
            )

        default:
            break
        }
    }
}

// MARK: - Environment buid methods

extension SectionDetailsMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> Environment {
        F.Environments.sectionDetails
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        Environment(
            loadMovies: { _, _ in Movie.fakeItems() },
            loadShows: { _, _ in Show.fakeItems() }
        )
    }
}

// MARK: - Effects

private extension SectionDetailsMiddleware {
    struct LoadMoviesEffect: ConcurrencyEffect {
        let sectionId: MovieSection.ID?
        let page: Int
        let environment: SectionDetailsMiddleware.Environment

        func task(flowId: AnyHashable) async throws -> any Action {
            guard let section = sectionId else {
                throw CancellationError()
            }
            let data = try await environment.loadMovies(section, page)
            return ActionGroup {
                Actions.DidLoadItems(items: data, id: flowId)
                Actions.DidLoadNestedItems(parentId: section, items: data, id: flowId)
            }
        }
    }

    struct LoadShowsEffect: ConcurrencyEffect {
        let sectionId: ShowSection.ID?
        let page: Int
        let environment: SectionDetailsMiddleware.Environment

        func task(flowId: AnyHashable) async throws -> any Action {
            guard let section = sectionId else {
                throw CancellationError()
            }
            let data = try await environment.loadShows(section, page)
            return ActionGroup {
                Actions.DidLoadItems(items: data, id: flowId)
                Actions.DidLoadNestedItems(parentId: section, items: data, id: flowId)
            }
        }
    }
}
