//
//  MyFavoritesFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import SwiftUI
import Common
@preconcurrency import MediaModels

public protocol MyFavoritesFeature: AppReducer {
    associatedtype MyFavoritesRouting: Routing<MyFavoritesRoute>
    associatedtype MyFavoritesNetworkConnectivityForm: MyFavorites.NetworkConnectivityForm
    associatedtype MyFavoritesAllMovies: Storage<Movie>
    associatedtype MyFavoritesAllShows: Storage<Show>
    associatedtype MyFavoritesAllGenres: Storage<Genre>
    associatedtype MyFavoritesEnvironment: MyFavoritesEnvironmentProviding

    var myFavoritesFeatureState: MyFavoritesFeatureState<Self, MyFavoritesRouting> { get }
    var networkConnectivityForm: MyFavoritesNetworkConnectivityForm { get }
    var allMovies: MyFavoritesAllMovies { get }
    var allShows: MyFavoritesAllShows { get }
    var allGenres: MyFavoritesAllGenres { get }
}


public struct MyFavoritesFeatureState<AppState: MyFavoritesFeature, FeatureRouting: Routing<MyFavoritesRoute>>: FeatureState {
    var myFavoritesForm = MyFavoritesForm()
    var myFavoritesFlow = MyFavoritesFlow()
    
    public init() {}
    
    public static func entryPoint(input: Void) -> some View {
        MyFavoritesContainer<AppState>()
    }

    @MiddlewareBuilder<AppState>
    public static func registerMiddlewares(in store: any Store<AppState>) -> [MiddlewareWrapper<AppState>] {
        MyFavoritesMiddleware<AppState>.self
    }
}

public enum MyFavorites {
    public protocol NetworkConnectivityForm: UDF.Form {
        var satisfied: Bool { get }
    }
}
