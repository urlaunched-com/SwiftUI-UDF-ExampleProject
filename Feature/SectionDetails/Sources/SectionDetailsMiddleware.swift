//
//  SectionDetailsMiddleware.swift
//  Flick
//
//  Created by Alexander Sharko on 06.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import API
import Foundation
import UDF
@preconcurrency import Models

enum Cancellation: Hashable, CaseIterable {
    case loadMovies
    case loadShows
}

public final class SectionDetailsMiddleware<F: SectionDetailsFeature>: Middleware<F>, @unchecked Sendable {
    public struct Environment {
        var loadMovies: (_ section: String, _ page: Int) async throws -> [Movie]
        var loadShows: (_ section: String, _ page: Int) async throws -> [Show]
    }

    public var environment: Environment!

    public func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.sectionDetailsFlow
    }

    public override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    public func observe(state: F) {
        switch state.sectionDetailsFlow {
        case let .loadMovies(page):
            execute(
                effect: LoadMoviesEffect(
                    sectionId: state.sectionDetailsForm.movieSectionId,
                    page: page,
                    environment: environment
                ),
                flowId: SectionDetailsFlow.loadMoviesId,
                cancellation: Cancellation.loadMovies
            )

        case let .loadShows(page):
            execute(
                effect: LoadShowsEffect(
                    sectionId: state.sectionDetailsForm.showSectionId,
                    page: page,
                    environment: environment
                ),
                flowId: SectionDetailsFlow.loadShowsId,
                cancellation: Cancellation.loadShows
            )

        default:
            break
        }
    }
}

// MARK: - Environment buid methods

public extension SectionDetailsMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> Environment {
        Environment(
            loadMovies: { section, page in
                let movies = try await HomeAPIClient.loadMovies(section: section, page: page)
                return movies.map(\.asMovie)
            },
            loadShows: { section, page in
                let shows = try await HomeAPIClient.loadShows(section: section, page: page)
                return shows.map(\.asShow)
            }
        )
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
            let data = try await environment.loadMovies(section.urlValue, page)
            return ActionGroup {
                Actions.DidLoadItems(items: data, id: flowId)
                Actions.DidLoadNestedItems(parentId: section, items: data.map(\.id), id: flowId)
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
            let data = try await environment.loadShows(section.urlValue, page)
            return ActionGroup {
                Actions.DidLoadItems(items: data, id: flowId)
                Actions.DidLoadNestedItems(parentId: section, items: data.map(\.id), id: flowId)
            }
        }
    }
}
