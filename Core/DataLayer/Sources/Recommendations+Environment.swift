//
//  Recommendations+Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Recommendations
import API
import MediaModels

public extension RecommendationsEnvironment {
    static var environment: Self {
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
