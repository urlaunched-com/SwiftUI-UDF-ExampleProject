//
//  CastFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Models
import Common
import SwiftUI

public protocol CastFeature: AppReducer {
    associatedtype CastAllCast: Storage<Models.Cast>
    associatedtype CastFeatureRouting: Routing<CastRoute>

    var allCast: CastAllCast { get }
    
    var castFeatureState: CastFeatureState<Self, CastFeatureRouting> { get }
}

public struct CastFeatureState<AppState: CastFeature, FeatureRouting: Routing<CastRoute>>: FeatureState {
    public var castForm = CastForm()
    
    public init() {}
    
    public static func entryPoint(input: [Cast.ID]) -> some View {
        CastContainer<AppState>(cast: input)
    }
}
