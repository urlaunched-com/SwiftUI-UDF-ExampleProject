//
//  HomeFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Models
import UDF

public protocol HomeFeature: AppReducer {
    associatedtype HomeForm: HomeFeatureTypes.HomeForm
    associatedtype HomeFlow: HomeFeatureTypes.HomeFlow
    associatedtype MovieGenresFlow: HomeFeatureTypes.MovieGenresFlow
    associatedtype ShowGenresFlow: HomeFeatureTypes.ShowGenresFlow
    associatedtype NetworkConnectivityForm: HomeFeatureTypes.NetworkConnectivityForm
    associatedtype AllMovies: HomeFeatureTypes.AllMovies
    associatedtype AllShows: HomeFeatureTypes.AllShows

    var homeForm: HomeForm { get }
    var homeFlow: HomeFlow { get }
    var movieGenresFlow: MovieGenresFlow { get }
    var showGenresFlow: ShowGenresFlow { get }
    var networkConnectivityForm: NetworkConnectivityForm { get }
    var allMovies: AllMovies { get }
    var allShows: AllShows { get }
}

public enum HomeFeatureTypes {
    public protocol HomeForm: Form {
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

    public protocol NetworkConnectivityForm: Form {
        var satisfied: Bool { get }
    }

    public protocol AllMovies: Storage<Movie> {
        var moviesBySectionId: [MovieSection.ID: OrderedSet<Movie.ID>] { get }
    }

    public protocol AllShows: Storage<Show> {
        var showsBySectionId: [ShowSection.ID: OrderedSet<Show.ID>] { get }
    }
}
