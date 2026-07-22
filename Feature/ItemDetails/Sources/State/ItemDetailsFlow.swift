//
//  ItemDetailsFlow.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF
@preconcurrency import Models

public enum ItemDetailsFlow: IdentifiableFlow, @unchecked Sendable {
    case none
    case load

    public init() { self = .none }

    public mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.LoadItemDetails<ItemDetailsTarget>:
            self = .load

        case let action as Actions.DidLoadItem<Movie> where action.id == Self.id:
            self = .none
            
        case let action as Actions.DidLoadItem<Show> where action.id == Self.id:
            self = .none

        case let action as Actions.DidCancelEffect where action.cancellation is Cancellation:
            self = .none

        default:
            break
        }
    }
}
