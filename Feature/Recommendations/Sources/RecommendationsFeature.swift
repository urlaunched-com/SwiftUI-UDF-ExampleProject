//
//  RecommendationsFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Common
@preconcurrency import Models
import SwiftUI

public protocol RecommendationsFeature: AppReducer {
    associatedtype NetworkConnectivityForm: Recommendations.NetworkConnectivityForm
    associatedtype RecommendationsRouting: Routing<RecommendationsRoute>
    associatedtype AllGenres: Recommendations.AllGenres
    associatedtype AllMovies: Recommendations.AllMovies
    associatedtype AllShows: Recommendations.AllShows
    
    var recommendationsFeatureState: RecommendationsFeatureState<Self, RecommendationsRouting> { get }
    var networkConnectivityForm: NetworkConnectivityForm { get }
    
    var allGenres: AllGenres { get }
    var allMovies: AllMovies { get }
    var allShows: AllShows { get }
}

public struct RecommendationsFeatureState<AppState: RecommendationsFeature, FeatureRouting: Routing<RecommendationsRoute>>: FeatureState {
    @BindableReducer(RecommendationsForm.self, bindedTo: RecommendationsContainer<AppState>.self)
    var recommendationsForm
    @BindableReducer(RecommendationsFlow.self, bindedTo: RecommendationsContainer<AppState>.self)
    var recommendationsFlow
    
    public init() {}
    
    public static func entryPoint(input: RecomendationTarget) -> some View {
        RecommendationsContainer<AppState>(id: input)
    }
}

public enum Recommendations {
    public protocol NetworkConnectivityForm: UDF.Form {
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
