//
//  ReviewDetailsFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 18.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Models
import Common

public protocol ReviewDetailsFeature: AppReducer {
    associatedtype NetworkConnectivityForm: ReviewDetails.NetworkConnectivityForm
    associatedtype AllReviews: ReviewDetails.AllReviews
    associatedtype ReviewDetailsContainerType: BindableContainer where ReviewDetailsContainerType.ContainerState == Self, ReviewDetailsContainerType.ID == Review.ID
    associatedtype FeatureNavigation: Common.FeatureNavigation where FeatureNavigation.Routing.Route == ReviewDetailsRoute
    
    var allReviews: AllReviews { get }
    var reviewDetailsBindableFlow: BindableSource<Review.ID, ReviewDetailsFlow> { get }
    var reviewDetailsBindableForm: BindableSource<Review.ID, ReviewDetailsForm> { get }
    
    var networkConnectivityForm: NetworkConnectivityForm { get }
    
    var reviewDetailsNavigation: FeatureNavigation { get }
}

public enum ReviewDetails {
    public protocol NetworkConnectivityForm: Form {
        var satisfied: Bool { get }
    }
    
    public protocol AllReviews: Storage<Review> {
        var movieByID: [Movie.ID: [Review.ID]] { get }
    }
}
