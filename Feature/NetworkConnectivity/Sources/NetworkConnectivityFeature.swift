//
//  NetworkConnectivityFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//

import UDF
import SwiftUI
import Common

public protocol NetworkConnectivityFeature: AppReducer {
    var networkConnectivityFeatureState: NetworkConnectivityFeatureState<Self> { get }
}

public struct NetworkConnectivityFeatureState<AppState: NetworkConnectivityFeature>: FeatureState {
    public typealias FeatureRouting = EmptyRouting
    public var networkConnectivityForm = NetworkConnectivityForm()
    
    public init() {}
    
    public static func entryPoint(input: Void = ()) -> some View {
        EmptyView()
    }
}
