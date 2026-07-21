//
//  AppState+Reviews.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Common
import Models
import Reviews

extension AppState: ReviewsFeature {
    var reviewsBindableFlow: BindableSource<Models.ReviewsTarget, ReviewsFlow> {
        BindableSource(
            reducers: Dictionary(
                uniqueKeysWithValues: reviewsFlow.map { ($0.key, $0.value) }
            )
        )
    }
    
    var reviewsBindableForm: BindableSource<Models.ReviewsTarget, ReviewsForm> {
        BindableSource(
            reducers: Dictionary(
                uniqueKeysWithValues: reviewsForm.map { ($0.key, $0.value) }
            )
        )
    }
    
    typealias ReviewsContainerType = ReviewsContainer<Self, ReviewsRouting>
}

extension NetworkConnectivityForm: Reviews.NetworkConnectivityForm {}
extension AllReviews: Reviews.AllReviews {}
