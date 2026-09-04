//
//  HomeSectionFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Models
import SwiftUI
import Common

public protocol HomeSectionFeature: AppReducer {
    associatedtype AllMovies: Storage<Movie>
    associatedtype AllShows: Storage<Show>
    associatedtype AllGenres: Storage<Genre>
    associatedtype HomeSectionFeatureRouting: Routing<HomeSectionRoute>

    var allMovies: AllMovies { get }
    var allShows: AllShows { get }
    var allGenres: AllGenres { get }
    
    var homeSectionFeatureState: HomeSectionFeatureState<Self, HomeSectionFeatureRouting> { get }
}

public struct HomeSectionFeatureState<AppState: HomeSectionFeature, FeatureRouting: Routing<HomeSectionRoute>>: FeatureState {
    public struct Input {
        public let section: any Models.Section
        public let items: [any Item]
        
        public init(section: any Models.Section, items: [any Item]) {
            self.section = section
            self.items = items
        }
    }
    
    public init() {}
    
    public static func entryPoint(input: Input) -> some View {
        HomeSectionContainer<AppState, FeatureRouting>(section: input.section, items: input.items)
    }
}
