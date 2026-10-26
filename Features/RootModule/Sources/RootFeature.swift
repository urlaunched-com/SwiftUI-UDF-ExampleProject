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

/// What the app shell needs from the app that hosts it.
public protocol RootFeature: AppReducer {
    associatedtype RootRouting: Routing<RootRoute>

    var rootFeatureState: RootFeatureState<Self, RootRouting> { get }
}

/// The state of the app shell: onboarding presentation, the selected tab and every tab's navigation stack.
///
/// The shell shows the flows the app puts in its tabs, so every tab's content is an external route.
public struct RootFeatureState<AppState: RootFeature, FeatureRouting: Routing<RootRoute>>: FeatureState {
    public var rootForm = RootForm()
    public var tabBarForm = TabBarForm()

    public init() {}

    public static func entryPoint(input: Void = ()) -> some View {
        RootContainer<AppState>()
    }

    public static var destinations: some ViewModifier {}

    public static func registerMiddlewares(in store: any Store<AppState>) -> [MiddlewareWrapper<AppState>] {
    }
}
