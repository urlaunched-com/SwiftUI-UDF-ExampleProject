//
//  ReviewsStorage.swift
//  Flick
//
//  Created by Alexander Sharko on 08.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Foundation
import UDF

struct AllReviews: Reducible {
    var byId: [Review.ID: Review] = [:]
    var byMovieId: [Movie.ID: OrderedSet<Review.ID>] = [:]
    var byShowId: [Show.ID: OrderedSet<Review.ID>] = [:]

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.DidLoadNestedItems<Movie.ID, Review.ID>:
            byMovieId.append(action.items, by: action.parentId)

        case let action as Actions.DidLoadNestedItems<Show.ID, Review.ID>:
            byShowId.append(action.items, by: action.parentId)

        case let action as Actions.DidLoadItems<Review>:
            byId.insert(items: action.items)

        case let action as Actions.DidLoadItem<Review>:
            byId.insert(item: action.item)

        case let action as Actions.DidUpdateItem<Review>:
            byId[action.item.id] = action.item

        case let action as Actions.DeleteItem<Review>:
            byId.removeValue(forKey: action.item.id)

        default:
            break
        }
    }

    func reviewBy(id: Review.ID) -> Review {
        byId[id] ?? .empty
    }
}
