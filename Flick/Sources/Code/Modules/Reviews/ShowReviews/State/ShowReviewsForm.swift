//
//  ShowReviewsForm.swift
//  Flick
//
//  Created by Valentin Petrulia on 15.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF

struct ShowReviewsForm: Form {
    var paginator: Paginator = .init(
        Review.self,
        flowId: ShowReviewsFlow.id,
        perPage: kPerPage
    )
    var page: PaginationPage { paginator.page }
    var reviews: [Review.ID] { paginator.items.elements }
    var dialog: DialogStatus = .dismissed

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.Error where action.id == ShowReviewsFlow.id:
            dialog = .init(error: action.error)

        default:
            break
        }
    }
}
