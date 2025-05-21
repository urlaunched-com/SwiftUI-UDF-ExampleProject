//
//  GenresStorage.swift
//  Flick
//
//  Created by Alexander Sharko on 05.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import Foundation
import UDF

struct AllGenres: Reducible {
    var byId: [Genre.ID: Genre] = [:]

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.DidLoadItems<Genre>:
            byId.insert(items: action.items)

        case let action as Actions.DidLoadItem<Genre>:
            byId.insert(item: action.item)

        case let action as Actions.DidUpdateItem<Genre>:
            byId[action.item.id] = action.item

        case let action as Actions.DeleteItem<Genre>:
            byId.removeValue(forKey: action.item.id)

        default:
            break
        }
    }

    func genreBy(id: Genre.ID) -> Genre {
        byId[id] ?? .empty
    }
}
