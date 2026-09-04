//
//  OnboardingEntryPoint.swift
//  Flick
//
//  Created by Bogdan Petkanych on 31.08.2026.
//

import SwiftUI
import UDF

public struct OnboardingEntryPoint<F: OnboardingFeature> {
    public struct Parameters {
        public init() {}
    }

    public static func make(with parameters: Parameters) -> OnboardingContainer<F> {
        OnboardingContainer<F>()
    }
}
