//
//  MainHomeSectionFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Models

public protocol MainHomeSectionFeature: AppReducer {
    associatedtype AllMovies: Storage<Movie>
    associatedtype AllShows: Storage<Show>
    associatedtype AllGenres: Storage<Genre>

    var allMovies: AllMovies { get }
    var allShows: AllShows { get }
    var allGenres: AllGenres { get }
}
