//
//  ShowReviewDetailsMiddleware.swift
//  Flick
//
//  Created by Bogdan Petkanych on 18.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import API
import UDF
import UIKit
@preconcurrency import Models

enum Cancellation: Hashable {
    case loadShowReview(Review.ID)
}

public final class ReviewDetailsMiddleware<F: ReviewDetailsFeature>: Middleware<F>, @unchecked Sendable {

    public struct Environment: Sendable {
        var loadShowReview: @Sendable (_ reviewID: Review.ID) async throws -> Review
    }

    public var environment: Environment!
    
    public func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.reviewDetailsFeatureState.reviewDetailsFlow
    }

    public override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    public func observe(state: F) {
        for (id, flow) in state.reviewDetailsFeatureState.reviewDetailsFlow {
            switch flow {
            case let .loading(reviewID):
                execute(
                    effect: LoadShowReviewsEffect(
                        reviewID: reviewID,
                        environment: environment
                    ),
                    flowId: ReviewDetailsFlow.id,
                    cancellation: Cancellation.loadShowReview(id),
                    mapAction: {
                        $0.binded(to: ReviewDetailsContainer<F>.self, by: id)
                    }
                )
            default:
                break
            }
        }
    }
}

// MARK: - Environment build methods

public extension ReviewDetailsMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> Environment {
        .init(
            loadShowReview: { reviewID in
                try await ItemDetailsAPIClient.loadReview(reviewID: reviewID.value).asReview
            }
        )
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        .init(
            loadShowReview: { _ in Review.testItem() }
        )
    }
}

// MARK: - Effects
private extension ReviewDetailsMiddleware {
    struct LoadShowReviewsEffect: ConcurrencyEffect {
        let reviewID: Review.ID?
        let environment: ReviewDetailsMiddleware.Environment

        func task(flowId: AnyHashable) async throws -> any Action {
            guard let reviewID else {
                throw CancellationError()
            }
            let review = try await environment.loadShowReview(reviewID)
            return ActionGroup {
                Actions.DidLoadItem(item: review, id: flowId)
            }
        }
    }
}
