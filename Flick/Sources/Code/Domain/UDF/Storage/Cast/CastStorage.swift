//
//  CastStorage.swift
//  Flick
//
//  Created by Alexander Sharko on 20.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Foundation
import UDF

struct AllCast: Reducible {
    var byId: [Cast.ID: Cast] = [:]
    var byMovieId: [Movie.ID: OrderedSet<Cast.ID>] = [:]
    var byShowId: [Show.ID: OrderedSet<Cast.ID>] = [:]

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.DidLoadNestedItems<Movie.ID, Cast.ID>:
            byMovieId.append(action.items, by: action.parentId)

        case let action as Actions.DidLoadNestedItems<Show.ID, Cast.ID>:
            byShowId.append(action.items, by: action.parentId)

        case let action as Actions.DidLoadItems<Cast>:
            byId.insert(items: action.items)

        case let action as Actions.DidLoadItem<Cast>:
            byId.insert(item: action.item)

        case let action as Actions.DidUpdateItem<Cast>:
            byId[action.item.id] = action.item

        case let action as Actions.DeleteItem<Cast>:
            byId.removeValue(forKey: action.item.id)

        default:
            break
        }
    }

    func castBy(id: Cast.ID) -> Cast {
        byId[id] ?? .empty
    }
}
