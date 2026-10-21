//
//  ImageFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.05.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Common
import SwiftUI

public protocol ImageFeature: AppReducer {
    associatedtype Environments: ImageEnvironmentProviding
    associatedtype NetworkConnectivityForm: Image.NetworkConnectivityForm

    var networkConnectivityForm: NetworkConnectivityForm { get }
    
    var imageFeatureState: ImageFeatureState<Self> { get }
}

public struct ImageFeatureState<AppState: ImageFeature>: FeatureState {
    public typealias FeatureRouting = EmptyRouting
    
    var imageConfigsForm = ImageConfigsForm()
    var imageConfigsFlow = ImageConfigsFlow()
    
    public struct Input {
        public var size: CGSize
        public var path: String?
        public var type: ImageType = .poster
        public var isLoaderPresented: Bool = true
        
        public init(size: CGSize, path: String? = nil, type: ImageType = .poster, isLoaderPresented: Bool = true) {
            self.size = size
            self.path = path
            self.type = type
            self.isLoaderPresented = isLoaderPresented
        }
    }
    
    public init() {}
    
    public static func entryPoint(input: Input) -> some View {
        ImageContainer<AppState>(size: input.size, path: input.path, type: input.type, isLoaderPresented: input.isLoaderPresented)
    }

    public static func registerMiddlewares(in store: any Store<AppState>) -> [MiddlewareWrapper<AppState>] {
        ImageConfigsMiddleware<AppState>.self
    }
}

public enum Image {
    public protocol NetworkConnectivityForm: UDF.Form {
        var satisfied: Bool { get }
    }
}

/// The live environments the Image flow's middleware needs. The host supplies them, so the flow
/// never depends on the API layer that builds them.
public protocol ImageEnvironmentProviding {
    static var imageConfigs: ImageConfigsEnvironment { get }
}
