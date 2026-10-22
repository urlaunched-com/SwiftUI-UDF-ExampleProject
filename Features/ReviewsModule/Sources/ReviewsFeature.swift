//
//  ReviewsFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
@preconcurrency import Models
import Common
import SwiftUI

/// What the Reviews flow needs from the app that hosts it.
public protocol ReviewsFeature: AppReducer {
    associatedtype Environments: ReviewsEnvironmentProviding
    associatedtype NetworkConnectivityForm: Reviews.NetworkConnectivityForm
    associatedtype AllReviews: Reviews.AllReviews
    associatedtype ReviewsRouting: Routing<ReviewsRoute>

    var allReviews: AllReviews { get }
    var networkConnectivityForm: NetworkConnectivityForm { get }

    var reviewsFeatureState: ReviewsFeatureState<Self, ReviewsRouting> { get }
}

/// The state of the whole Reviews flow: the reviews section, the full reviews list and a single review.
///
/// The flow is entered through the reviews section. Everything beyond it is reached through the flow's
/// internal routes, which the app registers with ``destinations`` without knowing what they are.
public struct ReviewsFeatureState<AppState: ReviewsFeature, FeatureRouting: Routing<ReviewsRoute>>: NavigableFeatureState {
    @BindableReducer(ReviewsSectionForm.self, bindedTo: ReviewsSectionContainer<AppState>.self)
    var reviewsSectionForm
    @BindableReducer(ReviewsSectionFlow.self, bindedTo: ReviewsSectionContainer<AppState>.self)
    var reviewsSectionFlow

    @BindableReducer(ReviewsForm.self, bindedTo: ReviewsContainer<AppState>.self)
    var reviewsForm
    @BindableReducer(ReviewsFlow.self, bindedTo: ReviewsContainer<AppState>.self)
    var reviewsFlow

    @BindableReducer(ReviewDetailsForm.self, bindedTo: ReviewDetailsContainer<AppState>.self)
    var reviewDetailsForm
    @BindableReducer(ReviewDetailsFlow.self, bindedTo: ReviewDetailsContainer<AppState>.self)
    var reviewDetailsFlow

    public init() {}

    public static func entryPoint(input: ReviewsTarget) -> some View {
        ReviewsSectionContainer<AppState>(id: input)
    }

    /// Registers the flow's internal destinations on the navigation stack that hosts it.
    public static var destinations: some ViewModifier {
        ReviewsSectionRouting<AppState>.self
        ReviewsListRouting<AppState>.self
    }

    public static func registerMiddlewares(in store: any Store<AppState>) -> [MiddlewareWrapper<AppState>] {
        ReviewsSectionMiddleware<AppState>.self
        ReviewsMiddleware<AppState>.self
        ReviewDetailsMiddleware<AppState>.self
    }
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

/// The live environments the Reviews flow's middleware needs. The host supplies them, so the flow
/// never depends on the API layer that builds them.
public protocol ReviewsEnvironmentProviding {
    static var reviewsSection: ReviewsSectionEnvironment { get }
    static var reviews: ReviewsEnvironment { get }
    static var reviewDetails: ReviewDetailsEnvironment { get }
}
