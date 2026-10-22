//
//  Home+Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Home
import API
import MediaModels

public extension HomeEnvironment {
    static var environment: Self {
        HomeEnvironment(
            loadMovies: { section in
                let movies = try await HomeAPIClient.loadMovies(section: section.urlValue)
                return movies.map(\.asMovie)
            },
            loadShows: { section in
                let shows = try await HomeAPIClient.loadShows(section: section.urlValue)
                return shows.map(\.asShow)
            }
        )
    }
}

public extension HomeGenresEnvironment {
    static var environment: Self {
        HomeGenresEnvironment(
            loadMovieGenres: {
                let movieGenres = try await HomeAPIClient.loadMovieGenres()
                return movieGenres.map(\.asGenre)
            },
            loadShowGenres: {
                let showGenres = try await HomeAPIClient.loadShowGenres()
                return showGenres.map(\.asGenre)
            }
        )
    }
}
