//
//  MyFavoritesFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Models
import SwiftUI
import Common

public protocol MyFavoritesFeature: AppReducer {
    associatedtype MyFavoritesRouting: Routing<MyFavoritesRoute>
    associatedtype MyFavoritesNetworkConnectivityForm: MyFavorites.NetworkConnectivityForm
    associatedtype MyFavoritesAllMovies: Storage<Movie>
    associatedtype MyFavoritesAllShows: Storage<Show>
    associatedtype MyFavoritesAllGenres: Storage<Genre>

    var myFavoritesForm: MyFavoritesForm { get }
    var myFavoritesFlow: MyFavoritesFlow { get }
    var networkConnectivityForm: MyFavoritesNetworkConnectivityForm { get }
    var allMovies: MyFavoritesAllMovies { get }
    var allShows: MyFavoritesAllShows { get }
    var allGenres: MyFavoritesAllGenres { get }
    var myFavoritesState: MyFavoritesState<Self, MyFavoritesRouting> { get }
}


public struct MyFavoritesState<AppState: MyFavoritesFeature, FeatureRouting: Routing<MyFavoritesRoute>>: FeatureState {
    var myFavoritesForm = MyFavoritesForm()
    var myFavoritesFlow = MyFavoritesFlow()
    
    public init() {}
    
    public static func entryPoint(input: Void) -> some View {
        MyFavoritesContainer<AppState>()
    }
}

public enum MyFavorites {
    public protocol NetworkConnectivityForm: UDF.Form {
        var satisfied: Bool { get }
    }
}
