//
//  Reviews+Live.swift
//  Flick
//
//  Created by Maksym Horobets on 15.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import API
import Models
import Reviews

public extension ReviewsEnvironment {
    static var live: Self {
        .init(
            loadShowReviews: { showID, page in
                try await ItemDetailsAPIClient.loadShowReviews(
                    showId: showID,
                    page: page
                )
                .map(\.asReview)
            },
            loadMovieReviews: { movieID, page in
                try await ItemDetailsAPIClient.loadMovieReviews(
                    movieId: movieID,
                    page: page
                )
                .map(\.asReview)
            }
        )
    }
}

public extension ReviewDetailsEnvironment {
    static var live: Self {
        .init(
            loadShowReview: { reviewID in
                try await ItemDetailsAPIClient.loadReview(reviewID: reviewID.value).asReview
            }
        )
    }
}

public extension ReviewsSectionEnvironment {
    static var live: Self {
        .init(
            loadShowReviews: { showID, page in
                try await ItemDetailsAPIClient.loadShowReviews(
                    showId: showID,
                    page: page
                )
                .map(\.asReview)
            },
            loadMovieReviews: { movieID, page in
                try await ItemDetailsAPIClient.loadMovieReviews(
                    movieId: movieID,
                    page: page
                )
                .map(\.asReview)
            }
        )
    }
}
