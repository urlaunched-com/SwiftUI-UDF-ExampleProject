//
//  HomeFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Common
import UDF
@preconcurrency import Models
import SwiftUI

/// What the Home flow needs from the app that hosts it.
public protocol HomeFeature: AppReducer {
    associatedtype Environments: HomeEnvironmentProviding
    associatedtype NetworkConnectivityForm: HomeFeatureTypes.NetworkConnectivityForm
    associatedtype AllMovies: HomeFeatureTypes.AllMovies
    associatedtype AllShows: HomeFeatureTypes.AllShows
    associatedtype AllGenres: Storage<Genre>
    associatedtype HomeRouting: Routing<HomeRoute>

    var networkConnectivityForm: NetworkConnectivityForm { get }
    var allMovies: AllMovies { get }
    var allShows: AllShows { get }
    var allGenres: AllGenres { get }

    var homeFeatureState: HomeFeatureState<Self, HomeRouting> { get }
}

/// The state of the whole Home flow: the home page with its sections and the full list of a section.
///
/// The flow is entered through the home page. Everything beyond it is reached through the flow's
/// internal routes, which the app registers with ``destinations`` without knowing what they are.
public struct HomeFeatureState<AppState: HomeFeature, FeatureRouting: Routing<HomeRoute>>: NavigableFeatureState {
    public var homeForm = HomeForm()
    public var homeFlow = HomeFlow()
    public var movieGenresFlow = MovieGenresFlow()
    public var showGenresFlow = ShowGenresFlow()

    var sectionDetailsForm = SectionDetailsForm()
    var sectionDetailsFlow = SectionDetailsFlow()

    public init() {}

    public static func entryPoint(input: Void = ()) -> some View {
        HomeContainer<AppState>()
    }

    /// Registers the flow's internal destinations on the navigation stack that hosts it.
    public static var destinations: some ViewModifier {
        MainHomeSectionRouting<AppState>.self
        HomeSectionRouting<AppState>.self
        SectionDetailsRouting<AppState>.self
    }

    public static func registerMiddlewares(in store: any Store<AppState>) -> [MiddlewareWrapper<AppState>] {
        HomeMiddleware<AppState>.self
        GenresMiddleware<AppState>.self
        SectionDetailsMiddleware<AppState>.self
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

/// The live environments the Home flow's middleware needs. The host supplies them, so the flow
/// never depends on the API layer that builds them.
public protocol HomeEnvironmentProviding {
    static var home: HomeEnvironment { get }
    static var genres: GenresEnvironment { get }
    static var sectionDetails: SectionDetailsEnvironment { get }
}
