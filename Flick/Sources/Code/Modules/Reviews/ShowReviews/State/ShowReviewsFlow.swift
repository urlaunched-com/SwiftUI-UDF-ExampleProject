//
//  ShowReviewsFlow.swift
//  Flick
//
//  Created by Valentin Petrulia on 15.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

enum ShowReviewsFlow: IdentifiableFlow {
    case none, loadShowReviews(Int)

    init() { self = .none }

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.LoadPage where action.id == Self.id:
            self = .loadShowReviews(action.pageNumber)

        case let action as Actions.DidLoadItems<Review> where action.id == Self.id:
            self = .none

        case let action as Actions.DidCancelEffect
            where action.cancellation is ShowReviewsMiddleware.Cancellation:
            self = .none

        case let action as Actions.Error where action.id == Self.id:
            self = .none

        default:
            break
        }
    }
}
