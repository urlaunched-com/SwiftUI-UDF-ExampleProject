//
//  Reviews+Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Reviews
import API
import ReviewModels

public extension ReviewsEnvironment {
    static var environment: Self {
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
