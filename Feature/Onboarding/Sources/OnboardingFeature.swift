//
//  OnboardingFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF

public protocol OnboardingFeature: AppReducer {
    associatedtype RootForm: Onboarding.RootForm
    
    var rootForm: RootForm { get }
}

public enum Onboarding {
    public protocol RootForm: Form {
        var isNeedToPresentOnboarding: Bool { get set }
    }
}
