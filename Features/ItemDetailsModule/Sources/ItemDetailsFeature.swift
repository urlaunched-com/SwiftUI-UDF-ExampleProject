//
//  ItemDetailsFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Common
@preconcurrency import Models
import SwiftUI

/// What the Item Details flow needs from the app that hosts it.
public protocol ItemDetailsFeature: AppReducer {
    associatedtype Environments: ItemDetailsEnvironmentProviding
    associatedtype NetworkConnectivityForm: ItemDetails.NetworkConnectivityForm
    associatedtype AllMovies: ItemDetails.AllMovies
    associatedtype AllShows: ItemDetails.AllShows
    associatedtype AllGenres: Storage<Genre>
    associatedtype AllCast: ItemDetails.AllCast
    associatedtype ItemDetailsRouting: Routing<ItemDetailsRoute>

    var networkConnectivityForm: NetworkConnectivityForm { get }
    var allMovies: AllMovies { get }
    var allShows: AllShows { get }
    var allGenres: AllGenres { get }
    var allCast: AllCast { get }

    var itemDetailsFeatureState: ItemDetailsFeatureState<Self, ItemDetailsRouting> { get }
}

/// The state of the whole Item Details flow: the details page with its cast and recommendations
/// sections, the full cast and recommendations lists, and where to watch.
///
/// The flow is entered through the details page. Everything beyond it is reached through the flow's
/// internal routes, which the app registers with ``destinations`` without knowing what they are.
public struct ItemDetailsFeatureState<AppState: ItemDetailsFeature, FeatureRouting: Routing<ItemDetailsRoute>>: FeatureState, DeepLinkableFeatureState {
    @BindableReducer(ItemDetailsForm.self, bindedTo: ItemDetailsContainer<AppState>.self)
    var itemDetailsForm
    @BindableReducer(ItemDetailsFlow.self, bindedTo: ItemDetailsContainer<AppState>.self)
    var itemDetailsFlow

    @BindableReducer(CastSectionFlow.self, bindedTo: CastSectionContainer<AppState>.self)
    var castSectionFlow
    public var castForm = CastForm()

    @BindableReducer(RecommendationsSectionForm.self, bindedTo: RecommendationsSectionContainer<AppState>.self)
    var recommendationsSectionForm
    @BindableReducer(RecommendationsSectionFlow.self, bindedTo: RecommendationsSectionContainer<AppState>.self)
    var recommendationsSectionFlow

    @BindableReducer(RecommendationsForm.self, bindedTo: RecommendationsContainer<AppState>.self)
    var recommendationsForm
    @BindableReducer(RecommendationsFlow.self, bindedTo: RecommendationsContainer<AppState>.self)
    var recommendationsFlow

    public init() {}

    public static func entryPoint(input: ItemDetailsTarget) -> some View {
        ItemDetailsContainer<AppState>(id: input)
    }

    /// Registers the flow's internal destinations on the navigation stack that hosts it.
    public static var destinations: some ViewModifier {
        ItemDetailsScreenRouting<AppState>.self
        CastSectionRouting<AppState>.self
        RecommendationsSectionRouting<AppState>.self
        RecommendationsRouting<AppState>.self
    }

    /// The routing of the details page an ``ItemDetailsTarget`` link opens.
    public typealias LinkRouting = ItemDetailsLinkRouting<AppState>

    public static func registerMiddlewares(in store: any Store<AppState>) -> [MiddlewareWrapper<AppState>] {
        ItemDetailsMiddleware<AppState>.self
        CastSectionMiddleware<AppState>.self
        RecommendationsSectionMiddleware<AppState>.self
        RecommendationsMiddleware<AppState>.self
    }
}

public enum ItemDetails {
    public protocol NetworkConnectivityForm: UDF.Form {
        var satisfied: Bool { get }
    }

    public protocol AllMovies: Storage<Movie> {
        var recommendationsByMovieId: [Movie.ID: OrderedSet<Movie.ID>] { get }
    }

    public protocol AllShows: Storage<Show> {
        var recommendationsByShowId: [Show.ID: OrderedSet<Show.ID>] { get }
    }

    public protocol AllCast: Storage<Models.Cast> {
        var byMovieId: [Movie.ID: OrderedSet<Models.Cast.ID>] { get }
        var byShowId: [Show.ID: OrderedSet<Models.Cast.ID>] { get }
    }
}

/// The live environments the ItemDetails flow's middleware needs. The host supplies them, so the flow
/// never depends on the API layer that builds them.
public protocol ItemDetailsEnvironmentProviding {
    static var itemDetails: ItemDetailsEnvironment { get }
    static var castSection: CastSectionEnvironment { get }
    static var recommendationsSection: RecommendationsSectionEnvironment { get }
    static var recommendations: RecommendationsEnvironment { get }
}
