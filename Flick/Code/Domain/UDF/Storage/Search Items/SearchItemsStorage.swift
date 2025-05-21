//
//  SearchItemsStorage.swift
//  Flick
//
//  Created by Oksana Fedorchuk on 26.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Foundation
import UDF

struct AllSearchItems: Reducible {
    var byId: [SearchItem.ID: SearchItem] = [:]

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.DidLoadItems<SearchItem>:
            byId.insert(items: action.items)

        case let action as Actions.DidLoadItem<SearchItem>:
            byId.insert(item: action.item)

        case let action as Actions.DidUpdateItem<SearchItem>:
            byId[action.item.id] = action.item

        case let action as Actions.DeleteItem<SearchItem>:
            byId.removeValue(forKey: action.item.id)

        default:
            break
        }
    }

    func searchItemBy(id: SearchItem.ID) -> SearchItem {
        byId[id] ?? .empty
    }
}
