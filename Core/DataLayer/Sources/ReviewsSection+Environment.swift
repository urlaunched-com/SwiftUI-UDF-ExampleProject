//
//  ReviewsSection+Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import ReviewsSection
import API
import ReviewModels

public extension ReviewsSectionEnvironment {
    static var environment: Self {
        ReviewsSectionEnvironment(
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
