//
//  SectionDetailsFlow.swift
//  Flick
//
//  Created by Alexander Sharko on 05.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

enum SectionDetailsFlow: IdentifiableFlow {
    case none, loadMovies(Int), loadShows(Int)

    init() { self = .none }

    static var loadMoviesId: FlowId = .init(value: "loadSectionMovies")
    static var loadShowsId: FlowId = .init(value: "loadSectionShows")

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

        case let action as Actions.DidCancelEffect where SectionDetailsMiddleware.Cancellation.allCases.contains { $0 == action.cancellation }:
            self = .none

        default:
            break
        }
    }
}
