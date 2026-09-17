//
//  TabBarFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Common
import UDF
import SwiftUI

public protocol TabBarFeature: AppReducer {
    var tabBarFeatureState: TabBarFeatureState<Self> { get }
}

public struct TabBarFeatureState<AppState: TabBarFeature>: FeatureState {
    public typealias FeatureRouting = EmptyRouting
    public var tabBarForm = TabBarForm()
    
    public init() {}
    
    public static func entryPoint(input: Void = ()) -> some View {
        TabBarContainer<AppState>()
    }
}
