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
import SwiftUI

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
    public protocol NetworkConnectivityForm: UDF.Form {
        var satisfied: Bool { get }
    }
    
    public protocol AllReviews: Storage<Review> {
        var byMovieId: [Movie.ID: OrderedSet<Review.ID>] { get }
        var byShowId: [Show.ID: OrderedSet<Review.ID>] { get }
    }
}

public protocol AppRouting: Routing {
    
}

public protocol Feature<AppState>: Reducible {
    associatedtype AppState: AppReducer
    associatedtype EntryPoint: View
    associatedtype Input
//    var navigation: FeatureRouting { get }
    
    static func entryPoint(input: Input) -> EntryPoint
}



public protocol ReviewsFeature2: AppReducer {
    associatedtype NetworkConnectivityForm: Reviews.NetworkConnectivityForm
    associatedtype AllReviews: Reviews.AllReviews
    associatedtype ReviewsNavigation: Common.FeatureNavigation where ReviewsNavigation.Routing.Route == ReviewsRoute
    
    var allReviews: AllReviews { get }
    var networkConnectivityForm: NetworkConnectivityForm { get }
    
    var reviewFeatureState: ReviewFeatureState<Self> { get }
}


public struct ReviewFeatureState<AppState: ReviewsFeature2>: Feature {
    
    @BindableReducer(ReviewsForm.self, bindedTo: ReviewsContainer<AppState>.self)
    public var reviewsForm
    @BindableReducer(ReviewsFlow.self, bindedTo: ReviewsContainer<AppState>.self)
    public var reviewsFlow
    
    public init() {
        fatalError()
    }
    
    public init(appState: AppState.Type) where AppState: ReviewsFeature2, Self.AppState == AppState {
        
    }
    
    public static func entryPoint(input: ReviewsTarget) -> some View {
        ReviewsContainer<AppState>(id: input)
    }
}
