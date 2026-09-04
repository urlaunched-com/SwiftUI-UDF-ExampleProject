//
//  MovieReviewsFlow.swift
//  Flick
//
//  Created by Valentin Petrulia on 15.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF
import Models

public enum ReviewsFlow: IdentifiableFlow {
    case none, loadReviews(Int)

    public init() { self = .none }

    public mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.LoadPage where action.id == Self.id:
            self = .loadReviews(action.pageNumber)

        case let action as Actions.DidLoadItems<Review> where action.id == Self.id:
            self = .none

        case let action as Actions.DidCancelEffect where action.cancellation is Cancellation:
            self = .none

        case let action as Actions.Error where action.id == Self.id:
            self = .none

        default:
            break
        }
    }
}
