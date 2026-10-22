//
//  ReviewDetails+Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import ReviewDetails
import API
import ReviewModels

public extension Environment {
    static var environment: Self {
        Environment(
            loadShowReview: { reviewID in
                try await ItemDetailsAPIClient.loadReview(reviewID: reviewID.value).asReview
            }
        )
    }
}
