//
//  WhereToWatchFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Common
import SwiftUI
@preconcurrency import MediaModels

public protocol WhereToWatchFeature: AppReducer {
    associatedtype HomeFlow: WhereToWatch.HomeFlow
    associatedtype WhereToWatchRouting: Routing<WhereToWatchRouter>
    
    var whereToWatchFeatureState: WhereToWatchFeatureState<Self, WhereToWatchRouting> { get }
    var homeFlow: HomeFlow { get }
}

public struct WhereToWatchFeatureState<AppState: WhereToWatchFeature, FeatureRouting: Routing<WhereToWatchRouter>>: FeatureState {
    public struct Input {
        public let item: any Item
        
        public init(item: any Item) {
            self.item = item
        }
    }
    
    public init() {}
    
    public static func entryPoint(input: Input) -> some View {
        WhereToWatchContainer<AppState>(item: input.item)
    }
    
    @MiddlewareBuilder<AppState>
    public static func registerMiddlewares(in store: any Store<AppState>) -> [MiddlewareWrapper<AppState>] { }
}

public enum WhereToWatch {
    public protocol HomeFlow: UDF.Form { }
}
