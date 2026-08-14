//
//  RecommendationsSectionFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//
import UDF
import Models
import Common
public protocol RecommendationsSectionFeature: AppReducer {
    associatedtype NetworkConnectivityForm: RecommendationsSection.NetworkConnectivityForm
    associatedtype RecomendationsSectionContainerType: BindableContainer where RecomendationsSectionContainerType.ContainerState == Self, RecomendationsSectionContainerType.ID == RecomendationTarget
    associatedtype AllGenres: RecommendationsSection.AllGenres
    associatedtype AllMovies: RecommendationsSection.AllMovies
    associatedtype AllShows: RecommendationsSection.AllShows
    
    var recommendationsSectionBindableForm: BindableSource<RecomendationTarget, RecommendationsSectionForm> { get }
    var recommendationsSectionBindableFlow: BindableSource<RecomendationTarget, RecommendationsSectionFlow> { get }
    var networkConnectivityForm: NetworkConnectivityForm { get }
    
    var allGenres: AllGenres { get }
    var allMovies: AllMovies { get }
    var allShows: AllShows { get }
}

public enum RecommendationsSection {
    public protocol NetworkConnectivityForm: Form {
        var satisfied: Bool { get }
    }
    
    public protocol AllGenres: Storage<Genre> {}
    
    public protocol AllMovies: Storage<Movie> {
        var recommendationsByMovieId: [Movie.ID: OrderedSet<Movie.ID>] { get }
    }
    
    public protocol AllShows: Storage<Show> {
        var recommendationsByShowId: [Show.ID: OrderedSet<Show.ID>] { get }
    }
}
