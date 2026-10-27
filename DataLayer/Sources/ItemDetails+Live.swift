//
//  ItemDetails+Live.swift
//  Flick
//
//  Created by Maksym Horobets on 15.10.2026.
//  © 2026 You are launched
//

import API
import Models
import ItemDetailsModule

public extension ItemDetailsEnvironment {
    static var live: Self {
        .init(
            loadMovieDetails: { movieId in
                try await ItemDetailsAPIClient.loadMovie(movieId: movieId.value).asMovie
            },
            loadShowDetails: { showId in
                try await ItemDetailsAPIClient.loadShow(showId: showId.value).asShow
            }
        )
    }
}

public extension RecommendationsEnvironment {
    static var live: Self {
        .init(
            loadMovies: { movieId, page in
                try await ItemDetailsAPIClient.loadMovieRecommendations(
                    movieId: movieId.value,
                    page: page
                )
                .map(\.asMovie)
            },
            loadShows: { showId, page in
                try await ItemDetailsAPIClient.loadShowRecommendations(
                    showId: showId.value,
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
                    movieId: movieId.value,
                    page: page
                )
                .map(\.asMovie)
            },
            loadShows: { showId, page in
                try await ItemDetailsAPIClient.loadShowRecommendations(
                    showId: showId.value,
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
                try await ItemDetailsAPIClient.loadMovieCast(movieId: movieId.value).map(\.asCast)
            },
            loadShowCast: { showId in
                try await ItemDetailsAPIClient.loadShowCast(showId: showId.value).map(\.asCast)
            }
        )
    }
}
