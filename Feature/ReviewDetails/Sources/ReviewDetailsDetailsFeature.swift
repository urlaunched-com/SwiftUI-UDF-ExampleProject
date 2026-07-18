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
    associatedtype NetworkConnectivityForm: ShowReviewDetails.NetworkConnectivityForm
    associatedtype AllReviews: ShowReviewDetails.AllReviews
    associatedtype ReviewDetailsContainerType: BindableContainer where ReviewDetailsContainerType.ContainerState == Self, ReviewDetailsContainerType.ID == Review.ID
    
    var allReviews: AllReviews { get }
    var reviewDetailsBindableFlow: BindableSource<Review.ID, ReviewDetailsFlow> { get }
    var reviewDetailsBindableForm: BindableSource<Review.ID, ReviewDetailsForm> { get }
    
    var networkConnectivityForm: NetworkConnectivityForm { get }
}

public enum ShowReviewDetails {
    public protocol NetworkConnectivityForm: Form {
        var satisfied: Bool { get }
    }
    
    public protocol AllReviews: Reducible {
        func reviewBy(id: Review.ID) -> Review
    }
}
