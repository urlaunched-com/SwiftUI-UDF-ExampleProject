//
//  AppEnvironments+RecommendationsSection.swift
//  Flick
//
//  Created by Bogdan Petkanych on 15.10.26.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import RecommendationsSection
import API

extension AppEnvironments: RecommendationsSectionEnvironmentProviding {
    static var recommendationsSectionEnvironment: RecommendationsSectionEnvironment {
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
