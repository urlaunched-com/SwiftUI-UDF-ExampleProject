//
//  ShowCastFlow.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF

enum ShowCastFlow: IdentifiableFlow {
    case none
    case loadShowCast(Show.ID)

    init() { self = .none }

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.LoadItemCast<Show.ID>:
            self = .loadShowCast(action.itemId)

        case let action as Actions.DidLoadItems<Cast> where action.id == Self.id:
            self = .none

        case let action as Actions.Error where action.id == Self.id:
            self = .none

        case let action as Actions.DidCancelEffect
            where action.cancellation is ShowCastMiddleware.Cancellation:
            self = .none

        default:
            break
        }
    }
}
