//
//  CastSectionFlow.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
@preconcurrency import Models

public enum CastSectionFlow: IdentifiableFlow {
    case none
    case loadMovieCast(Movie.ID)
    case loadShowCast(Show.ID)

    public init() { self = .none }

    public mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.LoadItemCast<Movie.ID>:
            self = .loadMovieCast(action.itemId)

        case let action as Actions.LoadItemCast<Show.ID>:
            self = .loadShowCast(action.itemId)

        case let action as Actions.DidLoadItems<Cast> where action.id == Self.id:
            self = .none

        case let action as Actions.Error where action.id == Self.id:
            self = .none

        case let action as Actions.DidCancelEffect
            where action.cancellation is CastSectionCancellation:
            self = .none

        default:
            break
        }
    }
}
