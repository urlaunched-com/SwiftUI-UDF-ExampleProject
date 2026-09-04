//
//  HomeEntryPoint.swift
//  Flick
//
//  Created by Bogdan Petkanych on 31.08.2026.
//

import SwiftUI
import Common
import Models
import UDF

public struct HomeEntryPoint<F: HomeFeature, R: Routing>: FeatureEntryPoint where R.Route == HomeRoute {
    public struct Parameters {
        public init() {}
    }

    public static func make(with parameters: Parameters) -> HomeContainer<F, R> {
        HomeContainer<F, R>()
    }
}
