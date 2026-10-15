//
//  AppEnvironments+ReviewDetails.swift
//  Flick
//
//  Created by Bogdan Petkanych on 15.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import ReviewDetails
import API

extension AppEnvironments: ReviewDetailsEnvironmentProviding {
    static var reviewDetailsEnvironment: Environment {
        Environment (
            loadShowReview: { reviewID in
                try await ItemDetailsAPIClient.loadReview(reviewID: reviewID.value).asReview
            }
        )
    }
}
