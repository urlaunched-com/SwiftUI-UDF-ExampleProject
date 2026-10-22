//
//  HomeFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Common
import SwiftUI
import SectionsModels
import MediaModels

public protocol HomeFeature: AppReducer {
    associatedtype NetworkConnectivityForm: HomeFeatureTypes.NetworkConnectivityForm
    associatedtype AllMovies: HomeFeatureTypes.AllMovies
    associatedtype AllShows: HomeFeatureTypes.AllShows
    associatedtype HomeFeatureRouting: Routing<HomeRoute>
    associatedtype HomeEnvironment: HomeEnvironmentProviding

    var networkConnectivityForm: NetworkConnectivityForm { get }
    var allMovies: AllMovies { get }
    var allShows: AllShows { get }
    
    var homeFeatureState: HomeFeatureState<Self, HomeFeatureRouting> { get }
}

public struct HomeFeatureState<AppState: HomeFeature, FeatureRouting: Routing<HomeRoute>>: FeatureState {
    public var homeForm = HomeForm()
    public var homeFlow = HomeFlow()
    public var movieGenresFlow = MovieGenresFlow()
    public var showGenresFlow = ShowGenresFlow()
    
    public init() {}
    
    public static func entryPoint(input: Void = ()) -> some View {
        HomeContainer<AppState>()
    }

    @MiddlewareBuilder<AppState>
    public static func registerMiddlewares(in store: any Store<AppState>) -> [MiddlewareWrapper<AppState>] {
        HomeMiddleware<AppState>.self
        GenresMiddleware<AppState>.self
    }
}

public enum HomeFeatureTypes {
    public protocol HomeForm: UDF.Form {
        var contentType: ContentType { get set }
        var dialog: DialogStatus { get set }
    }

    public protocol HomeFlow: Reducible {
        var isLoading: Bool { get }
    }

    public protocol MovieGenresFlow: Reducible {
        var isLoading: Bool { get }
    }

    public protocol ShowGenresFlow: Reducible {
        var isLoading: Bool { get }
    }

    public protocol NetworkConnectivityForm: UDF.Form {
        var satisfied: Bool { get }
    }

    public protocol AllMovies: Storage<Movie> {
        var moviesBySectionId: [MovieSection.ID: OrderedSet<Movie.ID>] { get }
    }

    public protocol AllShows: Storage<Show> {
        var showsBySectionId: [ShowSection.ID: OrderedSet<Show.ID>] { get }
    }
}
