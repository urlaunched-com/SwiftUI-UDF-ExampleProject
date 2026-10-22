//
//  MyFavorites+Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import MyFavorites
import API
import SectionsModels
import MediaModels

public extension MyFavoritesEnvironment {
    static var environment: Self {
        MyFavoritesEnvironment(
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
