//
//  MoviesStorage.swift
//  Flick
//
//  Created by Alexander Sharko on 01.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import Foundation
import UDF

struct AllMovies: Reducible {
    var byId: [Movie.ID: Movie] = [:]
    var moviesBySectionId: [MovieSection.ID: OrderedSet<Movie.ID>] = [:]
    var recommendationsByMovieId: [Movie.ID: OrderedSet<Movie.ID>] = [:]

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.DidLoadItems<Movie>:
            byId.insert(items: action.items)

        case let action as Actions.DidLoadNestedItems<MovieSection, Movie.ID>:
            moviesBySectionId.append(action.items, by: action.parentId)

        case let action as Actions.DidLoadNestedItems<Movie.ID, Movie.ID>:
            recommendationsByMovieId.append(action.items, by: action.parentId)

        case let action as Actions.DidLoadItem<Movie>:
            byId.insert(item: action.item)

        case let action as Actions.DidUpdateItem<Movie>:
            byId[action.item.id] = action.item

        case let action as Actions.DeleteItem<Movie>:
            byId.removeValue(forKey: action.item.id)

        default:
            break
        }
    }

    func movieBy(id: Movie.ID) -> Movie {
        byId[id] ?? .empty
    }
}
