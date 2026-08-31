//
//  RecommendationsSectionEntryPoint.swift
//  Flick
//
//  Created by Bogdan Petkanych on 31.08.2026.
//

import SwiftUI
import Common
import Models
import UDF

public struct RecommendationsSectionEntryPoint<F: RecommendationsSectionFeature, R: Routing>: FeatureEntryPoint where R.Route == RecommendationsSectionRoute {
    public struct Parameters {
        public let id: RecomendationTarget

        public init(id: RecomendationTarget) {
            self.id = id
        }
    }

    public static func make(with parameters: Parameters) -> RecommendationsSectionContainer<F, R> {
        RecommendationsSectionContainer<F, R>(id: parameters.id)
    }
}
