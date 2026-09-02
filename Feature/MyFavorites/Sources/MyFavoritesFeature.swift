//
//  MyFavoritesFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Models
import Common

public protocol MyFavoritesFeature: AppReducer {
    associatedtype MyFavoritesNetworkConnectivityForm: MyFavorites.NetworkConnectivityForm
    associatedtype MyFavoritesAllMovies: Storage<Movie>
    associatedtype MyFavoritesAllShows: Storage<Show>
    associatedtype MyFavoritesAllGenres: Storage<Genre>
    associatedtype MyFavoritesNavigation: Common.FeatureNavigation where MyFavoritesNavigation.Routing.Route == MyFavoritesRoute

    var myFavoritesForm: MyFavoritesForm { get }
    var myFavoritesFlow: MyFavoritesFlow { get }
    var networkConnectivityForm: MyFavoritesNetworkConnectivityForm { get }
    var allMovies: MyFavoritesAllMovies { get }
    var allShows: MyFavoritesAllShows { get }
    var allGenres: MyFavoritesAllGenres { get }
    var myFavoritesNavigation: MyFavoritesNavigation { get }
}

public enum MyFavorites {
    public protocol NetworkConnectivityForm: Form {
        var satisfied: Bool { get }
    }
}
