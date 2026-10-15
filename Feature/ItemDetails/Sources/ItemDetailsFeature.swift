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

public protocol ItemDetailsFeature: AppReducer {
    associatedtype AllMovies: Storage<Movie>
    associatedtype AllShows: Storage<Show>
    associatedtype AllGenres: Storage<Genre>
    associatedtype NetworkConnectivityForm: ItemDetails.NetworkConnectivityForm
    associatedtype ItemDetailsFeatureRouting: Routing<ItemDetailsRoute>
    associatedtype ItemDetailsEnvironment: ItemDetailsEnvironmentProviding

    var itemDetailsFeatureState: ItemDetailsFeatureState<Self, ItemDetailsFeatureRouting> { get }
    var networkConnectivityForm: NetworkConnectivityForm { get }
    
    var allMovies: AllMovies { get }
    var allShows: AllShows { get }
    var allGenres: AllGenres { get }
}

public struct ItemDetailsFeatureState<AppState: ItemDetailsFeature, FeatureRouting: Routing<ItemDetailsRoute>>: FeatureState {
    @BindableReducer(ItemDetailsForm.self, bindedTo: ItemDetailsContainer<AppState>.self)
    var itemDetailsForm
    @BindableReducer(ItemDetailsFlow.self, bindedTo: ItemDetailsContainer<AppState>.self)
    var itemDetailsFlow
    
    public init() {}
    
    public static func entryPoint(input: ItemDetailsTarget) -> some View {
        ItemDetailsContainer<AppState>(id: input)
    }

    @MiddlewareBuilder<AppState>
    public static func registerMiddlewares(in store: any Store<AppState>) -> [MiddlewareWrapper<AppState>] {
        ItemDetailsMiddleware<AppState>.self
    }
}

public enum ItemDetails {
    public protocol NetworkConnectivityForm: UDF.Form {
        var satisfied: Bool { get }
    }
}
