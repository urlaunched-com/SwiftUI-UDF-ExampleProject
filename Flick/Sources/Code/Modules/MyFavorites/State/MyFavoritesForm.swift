//
//  MyFavoritesForm.swift
//  Flick
//
//  Created by Vlad Andrieiev on 22.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF
@preconcurrency import Models
import Common

struct MyFavoritesForm: Form {
    var contentType: ContentType = .movie
    var moviesPaginator: Paginator = .init(
        Movie.self,
        flowId: MyFavoritesFlow.loadMoviesId,
        perPage: kPerPage
    )
    var moviesPage: PaginationPage { moviesPaginator.page }
    var movies: [Movie.ID] { moviesPaginator.items.elements }

    var showsPaginator: Paginator = .init(
        Show.self,
        flowId: MyFavoritesFlow.loadShowsId,
        perPage: kPerPage
    )
    var showsPage: PaginationPage { showsPaginator.page }
    var shows: [Show.ID] { showsPaginator.items.elements }

    var dialog: DialogStatus = .dismissed

    mutating func reduce(_ action: some Action) {
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
