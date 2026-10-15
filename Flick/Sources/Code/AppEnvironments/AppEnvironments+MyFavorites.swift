//
//  AppEnvironments+MyFavorites.swift
//  Flick
//
//  Created by Bogdan Petkanych on 15.10.26.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import MyFavorites
import API
import SectionsModels
import MediaModels

extension AppEnvironments: MyFavoritesEnvironmentProviding {
    static var myFavoritesEnvironment: MyFavoritesEnvironment {
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
