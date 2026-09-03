//
//  AppState+Reviews.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Common
import Models
import NetworkConnectivity
import Reviews

extension AppState: ReviewsFeature {
    typealias ReviewsRouting = AppRouter.ReviewsRouting
}

extension NetworkConnectivity.NetworkConnectivityForm: Reviews.NetworkConnectivityForm {}
extension AllReviews: Reviews.AllReviews {}
