//
//  RecommendationsFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Common
import Models

public protocol RecommendationsFeature: AppReducer {
    associatedtype NetworkConnectivityForm: Recommendations.NetworkConnectivityForm
    associatedtype RecomendationsContainerType: BindableContainer where RecomendationsContainerType.ContainerState == Self, RecomendationsContainerType.ID == RecomendationTarget
    associatedtype AllGenres: Recommendations.AllGenres
    associatedtype AllMovies: Recommendations.AllMovies
    associatedtype AllShows: Recommendations.AllShows
    
    var recommendationsBindableForm: BindableSource<RecomendationTarget, RecommendationsForm> { get }
    var recommendationsBindableFlow: BindableSource<RecomendationTarget, RecommendationsFlow> { get }
    var networkConnectivityForm: NetworkConnectivityForm { get }
    
    var allGenres: AllGenres { get }
    var allMovies: AllMovies { get }
    var allShows: AllShows { get }
}

public enum Recommendations {
    public protocol NetworkConnectivityForm: Form {
        var satisfied: Bool { get }
    }
    
    public protocol AllGenres: Reducible {
        func genreBy(id: Genre.ID) -> Genre
    }
    
    public protocol AllMovies: Reducible {
        var recommendationsByMovieId: [Movie.ID: OrderedSet<Movie.ID>] { get }
        func movieBy(id: Movie.ID) -> Movie
    }
    
    public protocol AllShows: Reducible {
        var recommendationsByShowId: [Show.ID: OrderedSet<Show.ID>] { get }
        func showBy(id: Show.ID) -> Show
    }
}
