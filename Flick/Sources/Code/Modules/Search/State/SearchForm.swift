//
//  SearchForm.swift
//  Flick
//
//  Created by Oksana Fedorchuk on 24.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Foundation
import SwiftFoundation
import UDF
@preconcurrency import Models
import Common

struct SearchForm: Form {
    var searchText = ""
    var paginator: Paginator = .init(
        SearchItem.self,
        flowId: SearchFlow.id,
        perPage: kPerPage
    )
    var page: PaginationPage { paginator.page }
    var items: [SearchItem.ID] { paginator.items.elements }
    var dialog: DialogStatus = .dismissed

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.Error where action.id == SearchFlow.id:
            dialog = .init(error: action.error)

        default:
            break
        }
    }
}
