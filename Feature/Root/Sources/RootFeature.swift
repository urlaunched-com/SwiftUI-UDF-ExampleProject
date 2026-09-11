//
//  RootFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Common
import SwiftUI
import UDF

public protocol RootFeature: AppReducer {
    associatedtype TabBarForm: RootType.TabBarForm
    associatedtype RootFeatureRouting: Routing<RootRoute>

    var rootFeatureState: RootFeatureState<Self, RootFeatureRouting> { get }
    var rootForm: RootForm { get }
    var tabBarForm: TabBarForm { get }
}

public struct RootFeatureState<AppState: RootFeature, FeatureRouting: Routing<RootRoute>>: FeatureState {
    public var rootForm = RootForm()
    
    public init() {}
    
    public static func entryPoint(input: Void = ()) -> some View {
        RootContainer<AppState>()
    }
}

public enum RootType {
    public protocol TabBarForm: UDF.Form {
        var selectedTab: TabBarItem { get set }
        var homeNavigationPath: NavigationPath { get set }
        var searchNavigationPath: NavigationPath { get set }
        var randomizerNavigationPath: NavigationPath { get set }
        var favoritesNavigationPath: NavigationPath { get set }
        var profileNavigationPath: NavigationPath { get set }
    }
}
