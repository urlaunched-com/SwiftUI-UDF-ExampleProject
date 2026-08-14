//
//  MyFavoritesFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Models

public protocol MyFavoritesFeature: AppReducer {
    associatedtype NetworkConnectivityForm: MyFavorites.NetworkConnectivityForm
    associatedtype AllMovies: Storage<Movie>
    associatedtype AllShows: Storage<Show>
    associatedtype AllGenres: Storage<Genre>

    var myFavoritesForm: MyFavoritesForm { get }
    var myFavoritesFlow: MyFavoritesFlow { get }
    var networkConnectivityForm: NetworkConnectivityForm { get }
    var allMovies: AllMovies { get }
    var allShows: AllShows { get }
    var allGenres: AllGenres { get }
}

public enum MyFavorites {
    public protocol NetworkConnectivityForm: Form {
        var satisfied: Bool { get }
    }
}
