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
    associatedtype NetworkConnectivityForm: Image.NetworkConnectivityForm
    associatedtype FeatureRouting: Routing<Void>

    var networkConnectivityForm: NetworkConnectivityForm { get }
    
    var imageFeatureState: ImageFeatureState<Self, FeatureRouting> { get }
}

public struct ImageFeatureState<AppState: ImageFeature, FeatureRouting: Routing<Void>>: FeatureState {
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
}

public enum Image {
    public protocol NetworkConnectivityForm: UDF.Form {
        var satisfied: Bool { get }
    }
}
