//
//  OnboardingFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import SwiftUI
import Common

public protocol OnboardingFeature: AppReducer {
    associatedtype RootForm: Onboarding.RootForm
    
    var onboardingFeatureState: OnboardingFeatureState<Self> { get }
    var rootForm: RootForm { get }
}

public struct OnboardingFeatureState<AppState: OnboardingFeature>: FeatureState {
    public typealias FeatureRouting = EmptyRouter
    public init() {}
    
    public static func entryPoint(input: Void = ()) -> some View {
        OnboardingContainer<AppState>()
    }
}

public enum Onboarding {
    public protocol RootForm: UDF.Form {
        var isNeedToPresentOnboarding: Bool { get set }
    }
}
