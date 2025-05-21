//
//  SectionDetailsForm.swift
//  Flick
//
//  Created by Alexander Sharko on 05.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF

struct SectionDetailsForm: Form {
    var moviesPaginator: Paginator = .init(
        Movie.self,
        flowId: SectionDetailsFlow.loadMoviesId,
        perPage: kPerPage
    )
    var moviesPage: PaginationPage { moviesPaginator.page }
    var movies: [Movie.ID] { moviesPaginator.items.elements }

    var showsPaginator: Paginator = .init(
        Show.self,
        flowId: SectionDetailsFlow.loadShowsId,
        perPage: kPerPage
    )
    var showsPage: PaginationPage { showsPaginator.page }
    var shows: [Show.ID] { showsPaginator.items.elements }

    var movieSectionId: MovieSection? = nil
    var showSectionId: ShowSection? = nil

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.SectionOpened<MovieSection>:
            movieSectionId = action.sectionId

        case let action as Actions.SectionOpened<ShowSection>:
            showSectionId = action.sectionId

        default:
            break
        }
    }
}
