//
//  SignInEntryPoint.swift
//  Flick
//
//  Created by Bogdan Petkanych on 31.08.2026.
//

import SwiftUI
import Common
import UDF

public struct SignInEntryPoint<F: SignInFeature, R: Routing>: FeatureEntryPoint where R.Route == SignInRoute {
    public struct Parameters {
        public init() {}
    }

    public static func make(with parameters: Parameters) -> SignInContainer<F, R> {
        SignInContainer<F, R>()
    }
}
