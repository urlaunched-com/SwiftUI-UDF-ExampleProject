//
//  ShowRecommendationsMiddleware.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import API
import UDF

final class ShowRecommendationsMiddleware: BaseObservableMiddleware<AppState> {
    enum Cancellation: Hashable {
        case loadShows(Show.ID)
    }

    struct Environment {
        var loadShows: (_ showId: Int, _ page: Int) async throws -> [Show]
    }

    var environment: Environment!

    func scope(for state: AppState) -> Scope {
        state.networkConnectivityForm
        state.showRecommendationsFlow
        state.showDetailsRecommendationsFlow
    }

    override func status(for state: AppState) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func observe(state: AppState) {
        for (id, flow) in state.showRecommendationsFlow {
            switch flow {
            case let .loadShows(page):
                execute(
                    effect: LoadShowsEffect(
                        showId: id,
                        page: page,
                        environment: environment
                    ),
                    flowId: ShowRecommendationsFlow.id,
                    cancellation: Cancellation.loadShows(id),
                    mapAction: {
                        $0.binded(to: state.showRecommendationsFlow.containerType, by: id)
                    }
                )

            default:
                break
            }
        }

        for (id, flow) in state.showDetailsRecommendationsFlow {
            switch flow {
            case let .loadShows(page):
                execute(
                    effect: LoadShowsEffect(
                        showId: id,
                        page: page,
                        environment: environment
                    ),
                    flowId: ShowRecommendationsFlow.id,
                    cancellation: Cancellation.loadShows(id),
                    mapAction: {
                        $0.binded(to: state.showDetailsRecommendationsFlow.containerType, by: id)
                    }
                )

            default:
                break
            }
        }
    }
}

// MARK: - Environment build methods

extension ShowRecommendationsMiddleware {
    static func buildLiveEnvironment(for _: some Store<AppState>) -> Environment {
        .init(
            loadShows: { showId, page in
                try await ItemDetailsAPIClient.loadShowRecommendations(
                    showId: showId,
                    page: page
                )
                .map(\.asShow)
            }
        )
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        .init(
            loadShows: { _, _ in Show.testItems(count: 3) }
        )
    }
}

// MARK: - Effects

private extension ShowRecommendationsMiddleware {
    struct LoadShowsEffect: ConcurrencyEffect {
        let showId: Show.ID?
        let page: Int
        let environment: ShowRecommendationsMiddleware.Environment

        func task(flowId: AnyHashable) async throws -> any Action {
            guard let showId else {
                throw CancellationError()
            }
            let shows = try await environment.loadShows(showId.value, page)
            return ActionGroup {
                Actions.DidLoadItems(items: shows, id: flowId)
                Actions.DidLoadNestedItems(parentId: showId, items: shows.ids)
            }
        }
    }
}
