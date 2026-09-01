//
//  ReviewsFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Common
import Models

public protocol ReviewsFeature: AppReducer {
    associatedtype NetworkConnectivityForm: Reviews.NetworkConnectivityForm
    associatedtype AllReviews: Reviews.AllReviews
    associatedtype ReviewsContainerType: BindableContainer where ReviewsContainerType.ContainerState == Self, ReviewsContainerType.ID == ReviewsTarget
    associatedtype ReviewsNavigation: Common.FeatureNavigation where ReviewsNavigation.Routing.Route == ReviewsRoute
    
    var allReviews: AllReviews { get }
    var networkConnectivityForm: NetworkConnectivityForm { get }
    var reviewsBindableFlow: BindableSource<ReviewsTarget, ReviewsFlow> { get }
    var reviewsBindableForm: BindableSource<ReviewsTarget, ReviewsForm> { get }
    
    var reviewsNavigation: ReviewsNavigation { get }
}

public enum Reviews {
    public protocol NetworkConnectivityForm: Form {
        var satisfied: Bool { get }
    }
    
    public protocol AllReviews: Storage<Review> {
        var byMovieId: [Movie.ID: OrderedSet<Review.ID>] { get }
        var byShowId: [Show.ID: OrderedSet<Review.ID>] { get }
    }
}
