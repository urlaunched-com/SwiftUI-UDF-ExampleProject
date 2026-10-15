//
//  AppState+.swift
//  Flick
//
//  Created by Bogdan Petkanych on 18.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Common
import NetworkConnectivity
import ReviewDetails
import MediaModels
import ReviewModels

extension AppState: ReviewDetailsFeature {
    typealias AllReviews = Flick.AllReviews
    typealias ReviewDetailsEnvironment = AppEnvironments
}

extension NetworkConnectivity.NetworkConnectivityForm: ReviewDetails.NetworkConnectivityForm {}
extension AllReviews: ReviewDetails.AllReviews {
    var movieByID: [MediaModels.Movie.ID: [ReviewModels.Review.ID]] {
        byMovieId.mapValues(Array.init)
    }
}
