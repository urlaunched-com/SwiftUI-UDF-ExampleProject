//
//  ShowRecommendationsFlow.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF

enum ShowRecommendationsFlow: IdentifiableFlow {
    case none, loadShows(Int)

    init() { self = .none }

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.LoadPage where action.id == Self.id:
            self = .loadShows(action.pageNumber)

        case let action as Actions.DidLoadItems<Show> where action.id == Self.id:
            self = .none

        case let action as Actions.DidCancelEffect
            where action.cancellation is ShowRecommendationsMiddleware.Cancellation:
            self = .none

        case let action as Actions.Error where action.id == Self.id:
            self = .none

        default:
            break
        }
    }
}
