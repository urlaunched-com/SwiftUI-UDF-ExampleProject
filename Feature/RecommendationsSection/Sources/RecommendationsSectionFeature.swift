//
//  RecommendationsSectionFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//
import UDF
@preconcurrency import Models
import Common
import SwiftUI

public protocol RecommendationsSectionFeature: AppReducer {
    associatedtype RecommendationsSectionEnvironment: RecommendationsSectionEnvironmentProviding
    associatedtype NetworkConnectivityForm: RecommendationsSection.NetworkConnectivityForm
    associatedtype AllGenres: RecommendationsSection.AllGenres
    associatedtype AllMovies: RecommendationsSection.AllMovies
    associatedtype AllShows: RecommendationsSection.AllShows
    associatedtype RecommendationsSectionRouting: Routing<RecommendationsSectionRoute>
    var recommendationsSectionFeatureState: RecommendationsSectionFeatureState<Self, RecommendationsSectionRouting> { get }
    var networkConnectivityForm: NetworkConnectivityForm { get }
    
    var allGenres: AllGenres { get }
    var allMovies: AllMovies { get }
    var allShows: AllShows { get }
}

public struct RecommendationsSectionFeatureState<AppState: RecommendationsSectionFeature, FeatureRouting: Routing<RecommendationsSectionRoute>>: FeatureState {
    @BindableReducer(RecommendationsSectionForm.self, bindedTo: RecommendationsSectionContainer<AppState>.self)
    var recommendationsSectionForm
    @BindableReducer(RecommendationsSectionFlow.self, bindedTo: RecommendationsSectionContainer<AppState>.self)
    var recommendationsSectionFlow
    
    public init() {}
    
    public static func entryPoint(input: RecomendationTarget) -> some View {
        RecommendationsSectionContainer<AppState>(id: input)
    }

    @MiddlewareBuilder<AppState>
    public static func registerMiddlewares(in store: any Store<AppState>) -> [MiddlewareWrapper<AppState>] {
        RecommendationsSectionMiddleware<AppState>.self
    }
}

public enum RecommendationsSection {
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
