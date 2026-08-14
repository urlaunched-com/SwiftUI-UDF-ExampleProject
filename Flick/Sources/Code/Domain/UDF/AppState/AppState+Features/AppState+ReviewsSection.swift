//
//  AppState+ReviewsSection.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import ReviewsSection
import Common
import Models
import NetworkConnectivity

extension AppState: ReviewsSectionFeature {
    typealias ReviewsSectionContainerType = ReviewsSectionContainer<Self, ReviewsSectionRouting>
    
    var reviewsSectionBindableForm: BindableSource<ReviewsTarget, ReviewsSectionForm> {
        BindableSource(
            reducers: Dictionary(
                uniqueKeysWithValues: reviewsSectionForm.map { ($0.key, $0.value) }
            )
        )
    }
    
    var reviewsSectionBindableFlow: BindableSource<ReviewsTarget, ReviewsSectionFlow> {
        BindableSource(
            reducers: Dictionary(
                uniqueKeysWithValues: reviewsSectionFlow.map { ($0.key, $0.value) }
            )
        )
    }
    
}
extension NetworkConnectivity.NetworkConnectivityForm: ReviewsSection.NetworkConnectivityForm {}
