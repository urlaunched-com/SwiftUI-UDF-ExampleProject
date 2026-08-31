//
//  ReviewDetailsEntryPoint.swift
//  Flick
//
//  Created by Bogdan Petkanych on 31.08.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//
import SwiftUI
import Common
import Models
import UDF

public struct ReviewDetailsEntryPoint<F: ReviewDetailsFeature, R: Routing>: FeatureEntryPoint where R.Route == ReviewDetailsRoute {
    public struct Parameters {
        public let reviewID: Review.ID
        
        public init(reviewID: Review.ID) {
            self.reviewID = reviewID
        }
    }
    
    public static func make(with parameters: Parameters) -> ReviewDetailsContainer<F, R> {
        ReviewDetailsContainer<F, R>(id: parameters.reviewID)
    }
}
