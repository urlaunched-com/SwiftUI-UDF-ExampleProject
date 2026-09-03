//
//  CastSectionFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Common
import Models
import UDF
import SwiftUI

public protocol CastSectionFeature: AppReducer {
    associatedtype CastSectionNetworkConnectivityForm: CastSection.NetworkConnectivityForm
    associatedtype CastSectionAllCast: CastSection.AllCast
    associatedtype CastSectionRouting: Routing<CastSectionRoute>
   
    var networkConnectivityForm: CastSectionNetworkConnectivityForm { get }
    var allCast: CastSectionAllCast { get }
    var castSectionFeatureState: CastSectionFeatureState<Self, CastSectionRouting> { get }
}

public struct CastSectionFeatureState<AppState: CastSectionFeature, FeatureRouting: Routing<CastSectionRoute>>: FeatureState {
    @BindableReducer(CastSectionFlow.self, bindedTo: CastSectionContainer<AppState>.self)
    var castSectionFlow
    
    public init() {}
    
    public static func entryPoint(input: CastSectionTarget) -> some View {
        CastSectionContainer<AppState>(id: input)
    }
}

public enum CastSection {
    public protocol NetworkConnectivityForm: UDF.Form {
        var satisfied: Bool { get }
    }

    public protocol AllCast: Storage<Models.Cast> {
        var byMovieId: [Movie.ID: OrderedSet<Models.Cast.ID>] { get }
        var byShowId: [Show.ID: OrderedSet<Models.Cast.ID>] { get }
    }
}
