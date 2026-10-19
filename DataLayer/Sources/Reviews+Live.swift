//
//  Reviews+Live.swift
//  Flick
//
//  Created by Maksym Horobets on 15.10.2026.
//  © 2026 You are launched
//

import API
import Models
import ReviewsModule

public extension ReviewsEnvironment {
    static var live: Self {
        .init(
            loadShowReviews: { showId, page in
                try await ItemDetailsAPIClient.loadShowReviews(
                    showId: showId.value,
                    page: page
                )
                .map(\.asReview)
            },
            loadMovieReviews: { movieId, page in
                try await ItemDetailsAPIClient.loadMovieReviews(
                    movieId: movieId.value,
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
            loadShowReviews: { showId, page in
                try await ItemDetailsAPIClient.loadShowReviews(
                    showId: showId.value,
                    page: page
                )
                .map(\.asReview)
            },
            loadMovieReviews: { movieId, page in
                try await ItemDetailsAPIClient.loadMovieReviews(
                    movieId: movieId.value,
                    page: page
                )
                .map(\.asReview)
            }
        )
    }
}
