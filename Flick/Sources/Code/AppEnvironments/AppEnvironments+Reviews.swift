//
//  AppEnvironments+Reviews.swift
//  Flick
//
//  Created by Bogdan Petkanych on 15.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Reviews
import API
import ReviewModels

extension AppEnvironments: ReviewsEnvironmentProviding {
    static var reviewsEnvironment: ReviewsEnvironment {
        ReviewsEnvironment(
            loadShowReviews: { showID, page in
                try await ItemDetailsAPIClient.loadShowReviews(
                    showId: showID.value,
                    page: page
                )
                .map(\.asReview)
            },
            loadMovieReviews: { movieID, page in
                try await ItemDetailsAPIClient.loadMovieReviews(
                    movieId: movieID.value,
                    page: page
                )
                .map(\.asReview)
            }
        )
    }
}
