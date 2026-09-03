//
//  ReviewDetailsFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 18.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
@preconcurrency import Models
import Common
import SwiftUI

public protocol ReviewDetailsFeature: AppReducer {
    associatedtype NetworkConnectivityForm: ReviewDetails.NetworkConnectivityForm
    associatedtype AllReviews: ReviewDetails.AllReviews
    associatedtype ReviewDetailsFeatureRouting: Routing<ReviewDetailsRoute>
    
    var allReviews: AllReviews { get }
    var networkConnectivityForm: NetworkConnectivityForm { get }
    
    var reviewDetailsFeatureState: ReviewDetailsFeatureState<Self, ReviewDetailsFeatureRouting> { get }
}

public struct ReviewDetailsFeatureState<AppState: ReviewDetailsFeature, FeatureRouting: Routing<ReviewDetailsRoute>>: FeatureState {
    @BindableReducer(ReviewDetailsForm.self, bindedTo: ReviewDetailsContainer<AppState>.self)
    var reviewDetailsForm
    @BindableReducer(ReviewDetailsFlow.self, bindedTo: ReviewDetailsContainer<AppState>.self)
    var reviewDetailsFlow
    
    public init() {}
    
    public static func entryPoint(input: Review.ID) -> some View {
        ReviewDetailsContainer<AppState>(id: input)
    }
}

public enum ReviewDetails {
    public protocol NetworkConnectivityForm: UDF.Form {
        var satisfied: Bool { get }
    }
    
    public protocol AllReviews: Storage<Review> {
        var movieByID: [Movie.ID: [Review.ID]] { get }
    }
}
