//
//  AppEnvironments+ReviewsSection.swift
//  Flick
//
//  Created by Bogdan Petkanych on 15.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import ReviewsSection
import API

extension AppEnvironments: ReviewsSectionEnvironmentProviding {
    static var reviewsSectionEnvironment: ReviewsSectionEnvironment {
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
