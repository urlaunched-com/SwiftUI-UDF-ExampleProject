//
//  ReviewsSectionEntryPoint.swift
//  Flick
//
//  Created by Bogdan Petkanych on 31.08.2026.
//

import SwiftUI
import Common
import Models
import UDF

public struct ReviewsSectionEntryPoint<F: ReviewsSectionFeature>: FeatureEntryPoint {
    public struct Parameters {
        public let id: ReviewsTarget

        public init(id: ReviewsTarget) {
            self.id = id
        }
    }

    public static func make(with parameters: Parameters) -> ReviewsSectionContainer<F> {
        ReviewsSectionContainer<F>(id: parameters.id)
    }
}
