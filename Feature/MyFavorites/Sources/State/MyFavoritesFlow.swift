//
//  MyFavoritesFlow.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Models

public enum MyFavoritesFlow: IdentifiableFlow {
    case none
    case loadMovies(Int)
    case loadShows(Int)

    public init() {
        self = .none
    }

    public static var loadMoviesId: FlowId = .init(value: "loadFavoritesMovie")
    public static var loadShowsId: FlowId = .init(value: "loadFavoritesShow")

    public mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.LoadPage where action.id == Self.loadMoviesId:
            self = .loadMovies(action.pageNumber)

        case let action as Actions.LoadPage where action.id == Self.loadShowsId:
            self = .loadShows(action.pageNumber)

        case let action as Actions.DidLoadItems<Movie> where action.id == Self.loadMoviesId:
            self = .none

        case let action as Actions.DidLoadItems<Show> where action.id == Self.loadShowsId:
            self = .none

        case let action as Actions.DidCancelEffect
            where MyFavoritesCancellation.allCases.contains(where: { $0 == action.cancellation }):
            self = .none

        case let action as Actions.Error where action.id == Self.loadMoviesId:
            self = .none

        case let action as Actions.Error where action.id == Self.loadShowsId:
            self = .none

        default:
            break
        }
    }
}
