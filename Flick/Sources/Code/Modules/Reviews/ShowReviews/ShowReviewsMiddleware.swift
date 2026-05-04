//
//  ShowReviewsMiddleware.swift
//  Flick
//
//  Created by Valentin Petrulia on 15.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import API
import UDF

final class ShowReviewsMiddleware: BaseObservableMiddleware<AppState> {
    enum Cancellation: Hashable {
        case loadShowReviews(Show.ID)
    }

    struct Environment {
        var loadShowReviews: (_ showId: Int, _ page: Int) async throws -> [Review]
    }

    var environment: Environment!

    func scope(for state: AppState) -> Scope {
        state.networkConnectivityForm
        state.showReviewsFlow
        state.showDetailsReviewsFlow
    }

    override func status(for state: AppState) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func observe(state: AppState) {
        for (id, flow) in state.showReviewsFlow {
            switch flow {
            case let .loadShowReviews(page):
                execute(
                    effect: LoadShowReviewsEffect(
                        showId: id,
                        page: page,
                        environment: environment
                    ),
                    flowId: ShowReviewsFlow.id,
                    cancellation: Cancellation.loadShowReviews(id),
                    mapAction: {
                        $0.binded(to: state.showReviewsFlow.containerType, by: id)
                    }
                )
            default:
                break
            }
        }

        for (id, flow) in state.showDetailsReviewsFlow {
            switch flow {
            case let .loadShowReviews(page):
                execute(
                    effect: LoadShowReviewsEffect(
                        showId: id,
                        page: page,
                        environment: environment
                    ),
                    flowId: ShowReviewsFlow.id,
                    cancellation: Cancellation.loadShowReviews(id),
                    mapAction: {
                        $0.binded(to: state.showDetailsReviewsFlow.containerType, by: id)
                    }
                )
            default:
                break
            }
        }
    }
}

// MARK: - Environment build methods

extension ShowReviewsMiddleware {
    static func buildLiveEnvironment(for _: some Store<AppState>) -> Environment {
        .init(
            loadShowReviews: { showId, page in
                try await ItemDetailsAPIClient.loadShowReviews(
                    showId: showId,
                    page: page
                )
                .map(\.asReview)
            }
        )
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        .init(
            loadShowReviews: { _, _ in Review.testItems(count: 3) }
        )
    }
}

// MARK: - Effects

private extension ShowReviewsMiddleware {
    struct LoadShowReviewsEffect: ConcurrencyEffect {
        let showId: Show.ID?
        let page: Int
        let environment: ShowReviewsMiddleware.Environment

        func task(flowId: AnyHashable) async throws -> any Action {
            guard let showId else {
                throw CancellationError()
            }
            let reviews = try await environment.loadShowReviews(showId.value, page)
            return ActionGroup {
                Actions.DidLoadItems(items: reviews, id: flowId)
                Actions.DidLoadNestedItems(parentId: showId, items: reviews.ids)
            }
        }
    }
}
