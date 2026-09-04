//
//  RootEntryPoint.swift
//  Flick
//
//  Created by Bogdan Petkanych on 31.08.2026.
//

import SwiftUI
import Common
import UDF

public struct RootEntryPoint<F: RootFeature, R: Routing>: FeatureEntryPoint where R.Route == RootRoute {

    public struct Parameters {
        public init() {}
    }

    public static func make(with parameters: Parameters) -> RootContainer<F, R> {
        RootContainer<F, R>()
    }
}
