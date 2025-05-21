//
//  ShowsStorage.swift
//  Flick
//
//  Created by Alexander Sharko on 01.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import Foundation
import UDF

struct AllShows: Reducible {
    var byId: [Show.ID: Show] = [:]
    var showsBySectionId: [ShowSection.ID: OrderedSet<Show.ID>] = [:]
    var recommendationsByShowId: [Show.ID: OrderedSet<Show.ID>] = [:]

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.DidLoadItems<Show>:
            byId.insert(items: action.items)

        case let action as Actions.DidLoadNestedItems<ShowSection, Show.ID>:
            showsBySectionId.append(action.items, by: action.parentId)

        case let action as Actions.DidLoadNestedItems<Show.ID, Show.ID>:
            recommendationsByShowId.append(action.items, by: action.parentId)

        case let action as Actions.DidLoadItem<Show>:
            byId.insert(item: action.item)

        case let action as Actions.DidUpdateItem<Show>:
            byId[action.item.id] = action.item

        case let action as Actions.DeleteItem<Show>:
            byId.removeValue(forKey: action.item.id)

        default:
            break
        }
    }

    func showBy(id: Show.ID) -> Show {
        byId[id] ?? .empty
    }
}
