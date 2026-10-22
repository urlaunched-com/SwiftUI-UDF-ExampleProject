//
//  ReviewsFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Common
import SwiftUI
@preconcurrency import MediaModels
@preconcurrency import ReviewModels

public protocol ReviewsFeature: AppReducer {
    associatedtype NetworkConnectivityForm: Reviews.NetworkConnectivityForm
    associatedtype AllReviews: Reviews.AllReviews
    associatedtype ReviewsRouting: Routing<ReviewsRoute>
    associatedtype ReviewsEnvironment: ReviewsEnvironmentProviding
    
    var allReviews: AllReviews { get }
    var networkConnectivityForm: NetworkConnectivityForm { get }
    
    var reviewsFeatureState: ReviewsFeatureState<Self, ReviewsRouting> { get }
}

public enum Reviews {
    public protocol NetworkConnectivityForm: UDF.Form {
        var satisfied: Bool { get }
    }
    
    public protocol AllReviews: Storage<Review> {
        var byMovieId: [Movie.ID: OrderedSet<Review.ID>] { get }
        var byShowId: [Show.ID: OrderedSet<Review.ID>] { get }
    }
}

public struct ReviewsFeatureState<AppState: ReviewsFeature, FeatureRouting: Routing<ReviewsRoute>>: FeatureState {
    @BindableReducer(ReviewsForm.self, bindedTo: ReviewsContainer<AppState>.self)
    var reviewsForm
    @BindableReducer(ReviewsFlow.self, bindedTo: ReviewsContainer<AppState>.self)
    var reviewsFlow
    
    public init() {}
    
    public static func entryPoint(input: ReviewsTarget) -> some View {
        ReviewsContainer<AppState>(id: input)
    }

    @MiddlewareBuilder<AppState>
    public static func registerMiddlewares(in store: any Store<AppState>) -> [MiddlewareWrapper<AppState>] {
        ReviewsMiddleware<AppState>.self
    }
}

