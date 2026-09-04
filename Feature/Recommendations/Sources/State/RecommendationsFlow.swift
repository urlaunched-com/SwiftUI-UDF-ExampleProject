//
//  RecommendationsFlow.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF
import Models

public enum RecommendationsFlow: IdentifiableFlow {
    case none
    case load(Int)

    public init() { self = .none }

    public mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.LoadPage where action.id == Self.id:
            self = .load(action.pageNumber)

        case let action as Actions.DidLoadItems<Movie> where action.id == Self.id:
            self = .none
            
        case let action as Actions.DidLoadItems<Show> where action.id == Self.id:
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
