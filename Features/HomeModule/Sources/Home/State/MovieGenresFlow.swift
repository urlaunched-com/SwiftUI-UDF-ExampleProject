//
//  MovieGenresFlow.swift
//  Flick
//
//  Created by Alexander Sharko on 15.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import UDF
import Models

public enum MovieGenresFlow: IdentifiableFlow, HomeFeatureTypes.MovieGenresFlow {
    case none, loading

    public init() { self = .loading }

    public var isLoading: Bool {
        self == .loading
    }

    public mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.DidLoadItems<Genre> where action.id == Self.id:
            self = .none

        case let action as Actions.DidCancelEffect where action.cancellation == HomeGenresCancellation.loadMovieGenres:
            self = .none

        default:
            break
        }
    }
}
