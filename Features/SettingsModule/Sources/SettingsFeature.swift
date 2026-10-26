//
//  SettingsFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import SwiftUI
import Common

public protocol SettingsFeature: AppReducer {
    associatedtype HomeForm: Reducible

    var settingsFeatureState: SettingsFeatureState<Self> { get }
    var homeForm: HomeForm { get }
}

public struct SettingsFeatureState<AppState: SettingsFeature>: FeatureState {
    public typealias FeatureRouting = EmptyRouting
    public init() {}
    
    public static func entryPoint(input: Void = ()) -> some View {
        SettingsContainer<AppState>()
    }

    public static var destinations: some ViewModifier {}

    public static func registerMiddlewares(in store: any Store<AppState>) -> [MiddlewareWrapper<AppState>] {
    }
}
