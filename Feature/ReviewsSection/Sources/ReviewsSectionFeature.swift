//
//  ReviewsSectionFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Models
import Common

public protocol ReviewsSectionFeature: AppReducer {
    associatedtype ReviewsSectionContainerType: BindableContainer where ReviewsSectionContainerType.ContainerState == Self, ReviewsSectionContainerType.ID == ReviewsTarget
    associatedtype NetworkConnectivityForm: ReviewsSection.NetworkConnectivityForm
    associatedtype AllReviews: Storage<Review>
    associatedtype ReviewsSectionNavigation: Common.FeatureNavigation where ReviewsSectionNavigation.Routing.Route == ReviewsSectionRoute
    
    var allReviews: AllReviews { get }
    var reviewsSectionBindableForm: BindableSource<ReviewsTarget, ReviewsSectionForm> { get }
    var reviewsSectionBindableFlow: BindableSource<ReviewsTarget, ReviewsSectionFlow> { get }
    var networkConnectivityForm: NetworkConnectivityForm { get }
    var reviewsSectionNavigation: ReviewsSectionNavigation { get }
}

public enum ReviewsSection {
    public protocol NetworkConnectivityForm: Form {
        var satisfied: Bool { get }
    }
}
