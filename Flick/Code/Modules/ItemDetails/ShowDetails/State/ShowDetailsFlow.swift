//
//  ShowDetailsFlow.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF

enum ShowDetailsFlow: IdentifiableFlow {
    case none
    case loadShow(Show.ID)

    init() { self = .none }

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.LoadItemDetails<Show.ID>:
            self = .loadShow(action.itemId)

        case let action as Actions.DidLoadItem<Show> where action.id == Self.id:
            self = .none

        case let action as Actions.DidCancelEffect
            where action.cancellation is ShowDetailsMiddleware.Cancellation:
            self = .none

        default:
            break
        }
    }
}
