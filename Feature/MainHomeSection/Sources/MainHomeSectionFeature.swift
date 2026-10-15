//
//  MainHomeSectionFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
@preconcurrency import Models
import SwiftUI
import Common
@preconcurrency import SectionsModels

public protocol MainHomeSectionFeature: AppReducer {
    associatedtype AllMovies: Storage<Movie>
    associatedtype AllShows: Storage<Show>
    associatedtype AllGenres: Storage<Genre>
    associatedtype MainHomeSectionFeatureRouting: Routing<MainHomeSectionRoute>

    var mainHomeSectionFeatureState: MainHomeSectionFeatureState<Self, MainHomeSectionFeatureRouting> { get }
    var allMovies: AllMovies { get }
    var allShows: AllShows { get }
    var allGenres: AllGenres { get }
}

public struct MainHomeSectionFeatureState<AppState: MainHomeSectionFeature, FeatureRouting: Routing<MainHomeSectionRoute>>: FeatureState {
    public enum Input {
        case movie(section: MovieSection, items: [any Item])
        case show(section: ShowSection, items: [any Item])
        
        public init(section: MovieSection, items: [any Item]) {
            self = .movie(section: section, items: items)
        }
        
        public init(section: ShowSection, items: [any Item]) {
            self = .show(section: section, items: items)
        }
    }
    
    public init() {}
    
    @ViewBuilder
    public static func entryPoint(input: Input) -> some View {
        switch input {
        case let .movie(section, items):
            MainHomeSectionContainer<AppState>(section: section, items: items)
        case let .show(section, items):
            MainHomeSectionContainer<AppState>(section: section, items: items)
        }
    }

    @MiddlewareBuilder<AppState>
    public static func registerMiddlewares(in store: any Store<AppState>) -> [MiddlewareWrapper<AppState>] { }
}
