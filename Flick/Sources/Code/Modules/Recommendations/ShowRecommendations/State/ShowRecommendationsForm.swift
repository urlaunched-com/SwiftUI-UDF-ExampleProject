//
//  ShowRecommendationsForm.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF
import Common
@preconcurrency import Models

struct ShowRecommendationsForm: Form {
    var paginator: Paginator = .init(
        Show.self,
        flowId: ShowRecommendationsFlow.id,
        perPage: kPerPage
    )
    var page: PaginationPage { paginator.page }
    var shows: [Show.ID] { paginator.items.elements }

    var dialog: DialogStatus = .dismissed

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.Error where action.id == ShowRecommendationsFlow.id:
            dialog = .init(error: action.error)

        default:
            break
        }
    }
}
