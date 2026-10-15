//
//  AppEnvironments+Recommendations.swift
//  Flick
//
//  Created by Bogdan Petkanych on 15.10.26.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Recommendations
import API
import MediaModels

extension AppEnvironments: RecommendationsEnvironmentProviding {
    static var recommendationsEnvironment: RecommendationsEnvironment {
        RecommendationsEnvironment(
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
