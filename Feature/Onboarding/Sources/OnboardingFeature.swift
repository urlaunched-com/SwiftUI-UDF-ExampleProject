//
//  OnboardingFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import SwiftUI

public protocol OnboardingFeature: AppReducer {
    associatedtype RootForm: Onboarding.RootForm
    
    var onboardingFeatureState: OnboardingFeatureState<Self> { get }
    var rootForm: RootForm { get }
}

public struct OnboardingFeatureState<AppState: OnboardingFeature>: FeatureState {
    public typealias FeatureRouting = EmptyRouting
    public init() {}
    
    public static func entryPoint(input: Void = ()) -> some View {
        OnboardingContainer<AppState>()
    }
    
    @MiddlewareBuilder<AppState>
    public static func registerMiddlewares(in store: any Store<AppState>) -> [MiddlewareWrapper<AppState>] { }
}

public enum Onboarding {
    public protocol RootForm: UDF.Form {
        var isNeedToPresentOnboarding: Bool { get set }
    }
}
