//
//  ItemDetails+Live.swift
//  Flick
//
//  Created by Maksym Horobets on 15.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import API
import Models
import ItemDetails

public extension ItemDetailsEnvironment {
    static var live: Self {
        .init(
            loadMovieDetails: { movieId in
                try await ItemDetailsAPIClient.loadMovie(movieId: movieId).asMovie
            },
            loadShowDetails: { showId in
                try await ItemDetailsAPIClient.loadShow(showId: showId).asShow
            }
        )
    }
}

public extension RecommendationsEnvironment {
    static var live: Self {
        .init(
            loadMovies: { movieId, page in
                try await ItemDetailsAPIClient.loadMovieRecommendations(
                    movieId: movieId,
                    page: page
                )
                .map(\.asMovie)
            },
            loadShows: { showsId, page in
                try await ItemDetailsAPIClient.loadShowRecommendations(
                    showId: showsId,
                    page: page
                ).map(\.asShow)
            }
        )
    }
}

public extension RecommendationsSectionEnvironment {
    static var live: Self {
        .init(
            loadMovies: { movieId, page in
                try await ItemDetailsAPIClient.loadMovieRecommendations(
                    movieId: movieId,
                    page: page
                )
                .map(\.asMovie)
            },
            loadShows: { showsId, page in
                try await ItemDetailsAPIClient.loadShowRecommendations(
                    showId: showsId,
                    page: page
                ).map(\.asShow)
            }
        )
    }
}

public extension CastSectionEnvironment {
    static var live: Self {
        .init(
            loadMovieCast: { movieId in
                try await ItemDetailsAPIClient.loadMovieCast(movieId: movieId).map(\.asCast)
            },
            loadShowCast: { showId in
                try await ItemDetailsAPIClient.loadShowCast(showId: showId).map(\.asCast)
            }
        )
    }
}
