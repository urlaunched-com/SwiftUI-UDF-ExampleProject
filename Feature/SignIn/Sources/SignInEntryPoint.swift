//
//  SignInEntryPoint.swift
//  Flick
//
//  Created by Bogdan Petkanych on 31.08.2026.
//

import SwiftUI
import Common
import UDF

public struct SignInEntryPoint<F: SignInFeature>: FeatureEntryPoint {
    public struct Parameters {
        public init() {}
    }

    public static func make(with parameters: Parameters) -> SignInContainer<F> {
        SignInContainer<F>()
    }
}
