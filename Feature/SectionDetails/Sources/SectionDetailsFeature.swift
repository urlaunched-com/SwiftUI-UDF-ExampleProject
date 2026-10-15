//
//  SectionDetailsFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import SwiftUI
import Common
@preconcurrency import SectionsModels
@preconcurrency import MediaModels

public protocol SectionDetailsFeature: AppReducer {
    associatedtype NetworkConnectivityForm: SectionDetails.NetworkConnectivityForm
    associatedtype AllMovies: SectionDetails.AllMovies
    associatedtype AllShows: SectionDetails.AllShows
    associatedtype HomeForm: SectionDetails.HomeForm
    associatedtype AllGenres: Storage<Genre>
    associatedtype SectionDetailsFeatureRouting: Routing<SectionDetailsRoute>
    associatedtype SectionDetailsEnvironment: SectionDetailsEnvironmentProviding
    
    var homeForm: HomeForm { get }
    var sectionDetailsFeatureState: SectionDetailsFeatureState<Self, SectionDetailsFeatureRouting> { get }
    var networkConnectivityForm: NetworkConnectivityForm { get }
    
    var allGenres: AllGenres { get }
    var allMovies: AllMovies { get }
    var allShows: AllShows { get }
}

public struct SectionDetailsFeatureState<AppState: SectionDetailsFeature, FeatureRouting: Routing<SectionDetailsRoute>>: FeatureState {
    var sectionDetailsForm = SectionDetailsForm()
    var sectionDetailsFlow = SectionDetailsFlow()
    
    public enum Input {
        case movie(MovieSection)
        case show(ShowSection)
        
        public init(section: MovieSection) { self = .movie(section) }
        public init(section: ShowSection) { self = .show(section) }
    }
    
    public init() {}
    
    @ViewBuilder
    public static func entryPoint(input: Input) -> some View {
        switch input {
        case let .movie(section):
            SectionDetailsContainer<AppState>(section: section)
        case let .show(section):
            SectionDetailsContainer<AppState>(section: section)
        }
    }

    @MiddlewareBuilder<AppState>
    public static func registerMiddlewares(in store: any Store<AppState>) -> [MiddlewareWrapper<AppState>] {
        SectionDetailsMiddleware<AppState>.self
    }
}

public enum SectionDetails {
    public protocol NetworkConnectivityForm: UDF.Form {
        var satisfied: Bool { get }
    }
    
    public protocol AllMovies: Storage<Movie> {
        var moviesBySectionId: [MovieSection.ID: OrderedSet<Movie.ID>] { get }
    }
    
    public protocol AllShows: Storage<Show> {
        var showsBySectionId: [ShowSection.ID: OrderedSet<Show.ID>] { get }
    }
    
    public protocol HomeForm: UDF.Form {
        var dialog: DialogStatus { get set }
    }
}
