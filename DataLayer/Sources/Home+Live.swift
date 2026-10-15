//
//  Home+Live.swift
//  Flick
//
//  Created by Maksym Horobets on 15.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import API
import Models
import Home

public extension HomeEnvironment {
    static var live: Self {
        .init(
            loadMovies: {
                let movies = try await HomeAPIClient.loadMovies(section: $0)
                return movies.map(\.asMovie)
            },
            loadShows: {
                let shows = try await HomeAPIClient.loadShows(section: $0)
                return shows.map(\.asShow)
            }
        )
    }
}

public extension GenresEnvironment {
    static var live: Self {
        .init(
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

public extension SectionDetailsEnvironment {
    static var live: Self {
        .init(
            loadMovies: { section, page in
                let movies = try await HomeAPIClient.loadMovies(section: section, page: page)
                return movies.map(\.asMovie)
            },
            loadShows: { section, page in
                let shows = try await HomeAPIClient.loadShows(section: section, page: page)
                return shows.map(\.asShow)
            }
        )
    }
}
