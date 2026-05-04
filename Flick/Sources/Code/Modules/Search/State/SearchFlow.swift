//
//  SearchFlow.swift
//  Flick
//
//  Created by Oksana Fedorchuk on 24.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

enum SearchFlow: IdentifiableFlow {
    case none, loadItems(Int)

    init() { self = .none }

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.LoadPage where action.id == Self.id:
            self = .loadItems(action.pageNumber)

        case let action as Actions.DidLoadItems<SearchItem> where action.id == Self.id:
            self = .none

        case let action as Actions.UpdateFormField<SearchForm> where action.keyPath == \SearchForm.searchText:
            self = .loadItems(1)

        default:
            break
        }
    }
}
