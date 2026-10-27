//
//  RecommendationsForm.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF
@preconcurrency import Models
import Common

public struct RecommendationsSectionForm: Form {
    var moviesPaginator: Paginator = .init(
        Movie.self,
        flowId: RecommendationsSectionFlow.id,
        perPage: kPerPage
    )
    var showsPaginator: Paginator = .init(
        Show.self,
        flowId: RecommendationsSectionFlow.id,
        perPage: kPerPage
    )
    
    var moviesPage: PaginationPage { moviesPaginator.page }
    var showsPage: PaginationPage { showsPaginator.page }
    
    var movies: [Movie.ID] { moviesPaginator.items.elements }
    var shows: [Show.ID] { showsPaginator.items.elements }
    
    var dialog: DialogStatus = .dismissed
    
    public init() {}

    public mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.Error where action.id == RecommendationsSectionFlow.id:
            dialog = .init(error: action.error)

        default:
            break
        }
    }
    
    public func pageNumber(for recomendationTarget: RecomendationTarget) -> Int {
        switch recomendationTarget {
        case .show:
            showsPage.pageNumber
        case .movie:
            moviesPage.pageNumber
        }
    }
}
