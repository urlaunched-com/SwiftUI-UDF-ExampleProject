//
//  RecommendationsSection+Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import RecommendationsSection
import API
import MediaModels

public extension RecommendationsSectionEnvironment {
    static var environment: Self {
        RecommendationsSectionEnvironment(
            loadMovies: { movieID, page in
                try await ItemDetailsAPIClient.loadMovieRecommendations(
                    movieId: movieID.value,
                    page: page
                )
                .map(\.asMovie)
            },
            loadShows: { showID, page in
                try await ItemDetailsAPIClient.loadShowRecommendations(
                    showId: showID.value,
                    page: page
                )
                .map(\.asShow)
            }
        )
    }
}
