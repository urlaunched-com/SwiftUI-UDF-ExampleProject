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
}

extension NetworkConnectivity.NetworkConnectivityForm: ReviewDetails.NetworkConnectivityForm {}
extension AllReviews: ReviewDetails.AllReviews {
    var movieByID: [Models.Movie.ID: [Models.Review.ID]] {
        byMovieId.mapValues(Array.init)
    }
}
