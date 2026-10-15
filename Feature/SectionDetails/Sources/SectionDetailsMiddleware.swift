//
//  SectionDetailsMiddleware.swift
//  Flick
//
//  Created by Alexander Sharko on 06.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Foundation
import UDF
@preconcurrency import SectionsModels
@preconcurrency import MediaModels

enum Cancellation: Hashable, CaseIterable {
    case loadMovies
    case loadShows
}

final class SectionDetailsMiddleware<F: SectionDetailsFeature>: Middleware<F>, @unchecked Sendable {
    var environment: SectionDetailsEnvironment!

    func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.sectionDetailsFeatureState.sectionDetailsFlow
    }

    override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func observe(state: F) {
        switch state.sectionDetailsFeatureState.sectionDetailsFlow {
        case let .loadMovies(page):
            execute(
                effect: LoadMoviesEffect(
                    sectionId: state.sectionDetailsFeatureState.sectionDetailsForm.movieSectionId,
                    page: page,
                    environment: environment
                ),
                flowId: SectionDetailsFlow.loadMoviesId,
                cancellation: Cancellation.loadMovies
            )

        case let .loadShows(page):
            execute(
                effect: LoadShowsEffect(
                    sectionId: state.sectionDetailsFeatureState.sectionDetailsForm.showSectionId,
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

extension SectionDetailsMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> SectionDetailsEnvironment {
        F.SectionDetailsEnvironment.sectionDetailsEnvironment
    }

    static func buildTestEnvironment(for _: some Store) -> SectionDetailsEnvironment {
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
        let environment: SectionDetailsEnvironment

        func task(flowId: AnyHashable) async throws -> any Action {
            guard let section = sectionId else {
                throw CancellationError()
            }
            let data = try await environment.loadMovies(section, page)
            return ActionGroup {
                Actions.DidLoadItems(items: data, id: flowId)
                Actions.DidLoadNestedItems(parentId: section, items: data.map(\.id), id: flowId)
            }
        }
    }

    struct LoadShowsEffect: ConcurrencyEffect {
        let sectionId: ShowSection.ID?
        let page: Int
        let environment: SectionDetailsEnvironment

        func task(flowId: AnyHashable) async throws -> any Action {
            guard let section = sectionId else {
                throw CancellationError()
            }
            let data = try await environment.loadShows(section, page)
            return ActionGroup {
                Actions.DidLoadItems(items: data, id: flowId)
                Actions.DidLoadNestedItems(parentId: section, items: data.map(\.id), id: flowId)
            }
        }
    }
}
