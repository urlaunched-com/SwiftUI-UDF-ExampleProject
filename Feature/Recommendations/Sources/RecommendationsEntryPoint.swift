//
//  RecommendationsEntryPoint.swift
//  Flick
//
//  Created by Bogdan Petkanych on 31.08.2026.
//

import SwiftUI
import Common
import Models
import UDF

public struct RecommendationsEntryPoint<F: RecommendationsFeature>: FeatureEntryPoint {

    public struct Parameters {
        public let id: RecomendationTarget

        public init(id: RecomendationTarget) {
            self.id = id
        }
    }

    public static func make(with parameters: Parameters) -> RecommendationsContainer<F> {
        RecommendationsContainer<F>(id: parameters.id)
    }
}
