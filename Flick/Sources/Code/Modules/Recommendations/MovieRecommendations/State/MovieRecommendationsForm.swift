//
//  MovieRecommendationsForm.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF

struct MovieRecommendationsForm: Form {
    var paginator: Paginator = .init(
        Movie.self,
        flowId: MovieRecommendationsFlow.id,
        perPage: kPerPage
    )

    var page: PaginationPage { paginator.page }
    var movies: [Movie.ID] { paginator.items.elements }

    var dialog: DialogStatus = .dismissed

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.Error where action.id == MovieRecommendationsFlow.id:
            dialog = .init(error: action.error)

        default:
            break
        }
    }
}
