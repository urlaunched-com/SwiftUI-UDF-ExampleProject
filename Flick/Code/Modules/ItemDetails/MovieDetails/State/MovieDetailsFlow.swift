//
//  MovieDetailsFlow.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF

enum MovieDetailsFlow: IdentifiableFlow {
    case none
    case loadMovie(Movie.ID)

    init() { self = .none }

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.LoadItemDetails<Movie.ID>:
            self = .loadMovie(action.itemId)

        case let action as Actions.DidLoadItem<Movie> where action.id == Self.id:
            self = .none

        case let action as Actions.DidCancelEffect
            where action.cancellation is MovieDetailsMiddleware.Cancellation:
            self = .none

        default:
            break
        }
    }
}
