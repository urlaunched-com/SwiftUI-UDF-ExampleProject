//
//  AppState+Reviews.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import NetworkConnectivityModule
import ReviewsModule

extension AppState: ReviewsFeature {
    typealias AllReviews = Flick.AllReviews
}

extension NetworkConnectivityModule.NetworkConnectivityForm: Reviews.NetworkConnectivityForm {}
extension AllReviews: Reviews.AllReviews {}
