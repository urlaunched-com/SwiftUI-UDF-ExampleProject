//
//  AppState+.swift
//  Flick
//
//  Created by Bogdan Petkanych on 18.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Common
import Models
import NetworkConnectivity
import ReviewDetails

extension AppState: ReviewDetailsFeature {
    typealias AllReviews = Flick.AllReviews
    typealias ReviewDetailsContainerType = ReviewDetailsContainer<Self>
    
    var reviewDetailsBindableFlow: BindableSource<Review.ID, ReviewDetailsFlow> {
        BindableSource(
            reducers: Dictionary(
                uniqueKeysWithValues: reviewDetailsFlow.map { ($0.key, $0.value) }
            )
        )
    }

    var reviewDetailsBindableForm: BindableSource<Review.ID, ReviewDetailsForm> {
        BindableSource(
            reducers: Dictionary(
                uniqueKeysWithValues: reviewDetailsForm.map { ($0.key, $0.value) }
            )
        )
    }
    
    struct ReviewDetailsAppNavigation: Common.FeatureNavigation {
        typealias EntryPoint = ReviewDetailsEntryPoint<AppState>
        
        var routing: AppRouter.ReviewDetailsRouting
        
        init(routing: AppRouter.ReviewDetailsRouting) {
            self.routing = routing
        }
    }
    
    var reviewDetailsNavigation: ReviewDetailsAppNavigation {
        ReviewDetailsAppNavigation(routing: AppRouter.shared.reviewDetailsRouting)
    }
}

extension NetworkConnectivity.NetworkConnectivityForm: ReviewDetails.NetworkConnectivityForm {}
extension AllReviews: ReviewDetails.AllReviews {
    var movieByID: [Models.Movie.ID: [Models.Review.ID]] {
        byMovieId.mapValues(Array.init)
    }
}
