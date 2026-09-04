//
//  MovieReviewsForm.swift
//  Flick
//
//  Created by Valentin Petrulia on 15.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF
@preconcurrency import Models
import Common

public struct ReviewsSectionForm: Form {
    var paginator: Paginator = .init(
        Review.self,
        flowId: ReviewsSectionFlow.id,
        perPage: kPerPage
    )
    var page: PaginationPage { paginator.page }
    var reviews: [Review.ID] { paginator.items.elements }
    var dialog: DialogStatus = .dismissed
    
    public init() {}

    public mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.Error where action.id == ReviewsSectionFlow.id:
            dialog = .init(error: action.error)
            
        default:
            break
        }
    }
}
