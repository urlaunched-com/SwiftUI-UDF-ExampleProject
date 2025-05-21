//
//  MovieCastFlow.swift
//  Flick
//
//  Created by Valentin Petrulia on 13.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF

enum MovieCastFlow: IdentifiableFlow {
    case none
    case loadMovieCast(Movie.ID)

    init() { self = .none }

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.LoadItemCast<Movie.ID>:
            self = .loadMovieCast(action.itemId)

        case let action as Actions.DidLoadItems<Cast> where action.id == Self.id:
            self = .none

        case let action as Actions.Error where action.id == Self.id:
            self = .none

        case let action as Actions.DidCancelEffect
            where action.cancellation is MovieCastMiddleware.Cancellation:
            self = .none

        default:
            break
        }
    }
}
