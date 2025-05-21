//
//  MyFavoritesFlow.swift
//  Flick
//
//  Created by Vlad Andrieiev on 22.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

enum MyFavoritesFlow: IdentifiableFlow {
    case none, loadMovies(Int), loadShows(Int)

    init() { self = .none }

    static var loadMoviesId: FlowId = .init(value: "loadFavoritesMovie")
    static var loadShowsId: FlowId = .init(value: "loadFavoritesShow")

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.LoadPage where action.id == Self.loadMoviesId:
            self = .loadMovies(action.pageNumber)

        case let action as Actions.LoadPage where action.id == Self.loadShowsId:
            self = .loadShows(action.pageNumber)

        case let action as Actions.DidLoadItems<Movie> where action.id == Self.loadMoviesId:
            self = .none

        case let action as Actions.DidLoadItems<Show> where action.id == Self.loadShowsId:
            self = .none

        case let action as Actions.DidCancelEffect where MyFavoritesMiddleware.Cancellation.allCases.contains { $0 == action.cancellation }:
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
