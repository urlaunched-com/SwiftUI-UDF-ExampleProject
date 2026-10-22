//
//  ShowReviewDetailsMiddleware.swift
//  Flick
//
//  Created by Bogdan Petkanych on 18.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import UIKit
@preconcurrency import Models

public struct ReviewDetailsEnvironment: Sendable {
    public var loadShowReview: @Sendable (_ reviewID: Review.ID) async throws -> Review

    public init(
        loadShowReview: @escaping @Sendable (_ reviewID: Review.ID) async throws -> Review
    ) {
        self.loadShowReview = loadShowReview
    }
}

enum ReviewDetailsCancellation: Hashable {
    case loadShowReview(Review.ID)
}

final class ReviewDetailsMiddleware<F: ReviewsFeature>: Middleware<F>, @unchecked Sendable {

    public typealias Environment = ReviewDetailsEnvironment
    public var environment: Environment!
    
    public func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.reviewsFeatureState.reviewDetailsFlow
    }

    public override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    public func observe(state: F) {
        for (id, flow) in state.reviewsFeatureState.reviewDetailsFlow {
            switch flow {
            case let .loading(reviewID):
                execute(
                    effect: LoadShowReviewsEffect(
                        reviewID: reviewID,
                        environment: environment
                    ),
                    flowId: ReviewDetailsFlow.id,
                    cancellation: ReviewDetailsCancellation.loadShowReview(id),
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

extension ReviewDetailsMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> Environment {
        F.Environments.reviewDetails
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
