//
//  ReviewsEntryPoint.swift
//  Flick
//
//  Created by Bogdan Petkanych on 31.08.2026.
//

import SwiftUI
import Common
import Models
import UDF

public struct ReviewsEntryPoint<F: ReviewsFeature, R: Routing>: FeatureEntryPoint where R.Route == ReviewsRoute {
    public struct Parameters {
        public let id: ReviewsTarget

        public init(id: ReviewsTarget) {
            self.id = id
        }
    }

    public static func make(with parameters: Parameters) -> ReviewsContainer<F, R> {
        ReviewsContainer<F, R>(id: parameters.id)
    }
}
