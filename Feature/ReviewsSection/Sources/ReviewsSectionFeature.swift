//
//  ReviewsSectionFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
@preconcurrency import Models
import Common
import SwiftUI

public protocol ReviewsSectionFeature: AppReducer {
    associatedtype NetworkConnectivityForm: ReviewsSection.NetworkConnectivityForm
    associatedtype AllReviews: Storage<Review>
    associatedtype ReviewsSectionRouting: Routing<ReviewsSectionRoute>
    
    var allReviews: AllReviews { get }
    var reviewsSectionFeatureState: ReviewsSectionFeatureState<Self, ReviewsSectionRouting> { get }
    var networkConnectivityForm: NetworkConnectivityForm { get }
}

public struct ReviewsSectionFeatureState<AppState: ReviewsSectionFeature, FeatureRouting: Routing<ReviewsSectionRoute>>: FeatureState {
    @BindableReducer(ReviewsSectionForm.self, bindedTo: ReviewsSectionContainer<AppState>.self)
    var reviewsSectionForm
    @BindableReducer(ReviewsSectionFlow.self, bindedTo: ReviewsSectionContainer<AppState>.self)
    var reviewsSectionFlow
    
    public init() {}
    
    public static func entryPoint(input: ReviewsTarget) -> some View {
        ReviewsSectionContainer<AppState>(id: input)
    }
}

public enum ReviewsSection {
    public protocol NetworkConnectivityForm: UDF.Form {
        var satisfied: Bool { get }
    }
}
