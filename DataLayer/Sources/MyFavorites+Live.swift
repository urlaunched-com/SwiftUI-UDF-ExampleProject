//
//  MyFavorites+Live.swift
//  Flick
//
//  Created by Maksym Horobets on 15.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import API
import Models
import MyFavorites

public extension MyFavoritesEnvironment {
    static var live: Self {
        .init(
            loadMovies: { page in
                let movies = try await HomeAPIClient.loadMovies(
                    section: MovieSection.nowPlaying.urlValue,
                    page: page
                )
                return movies.map(\.asMovie)
            },
            loadShows: { page in
                let shows = try await HomeAPIClient.loadShows(
                    section: ShowSection.popular.urlValue,
                    page: page
                )
                return shows.map(\.asShow)
            }
        )
    }
}
