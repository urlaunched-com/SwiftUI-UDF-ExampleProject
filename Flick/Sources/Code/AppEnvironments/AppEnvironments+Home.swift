//
//  AppEnvironments+Home.swift
//  Flick
//
//  Created by Bogdan Petkanych on 15.10.26.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Home
import API
import MediaModels

extension AppEnvironments: HomeEnvironmentProviding {
    static var homeEnvironment: HomeEnvironment {
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

    static var homeGenresEnvironment: HomeGenresEnvironment {
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
