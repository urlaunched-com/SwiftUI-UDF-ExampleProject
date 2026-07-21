//
//  MyFavoritesForm.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
@preconcurrency import Models
import Common

public struct MyFavoritesForm: Form {
    public var contentType: ContentType = .movie
    public var moviesPaginator: Paginator = .init(
        Movie.self,
        flowId: MyFavoritesFlow.loadMoviesId,
        perPage: kPerPage
    )
    public var moviesPage: PaginationPage { moviesPaginator.page }
    public var movies: [Movie.ID] { moviesPaginator.items.elements }

    public var showsPaginator: Paginator = .init(
        Show.self,
        flowId: MyFavoritesFlow.loadShowsId,
        perPage: kPerPage
    )
    public var showsPage: PaginationPage { showsPaginator.page }
    public var shows: [Show.ID] { showsPaginator.items.elements }

    public var dialog: DialogStatus = .dismissed

    public init() {}

    public mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.Error where action.id == MyFavoritesFlow.id:
            dialog = .init(error: action.error)

        case let action as Actions.Error where action.id == MyFavoritesFlow.loadMoviesId:
            dialog = .init(error: action.error)

        case let action as Actions.Error where action.id == MyFavoritesFlow.loadShowsId:
            dialog = .init(error: action.error)

        default:
            break
        }
    }
}
