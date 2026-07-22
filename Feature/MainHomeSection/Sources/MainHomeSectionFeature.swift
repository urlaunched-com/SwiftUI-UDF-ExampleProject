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
    associatedtype AllMovies: MainHomeSection.AllMovies
    associatedtype AllShows: MainHomeSection.AllShows
    associatedtype AllGenres: MainHomeSection.AllGenres

    var allMovies: AllMovies { get }
    var allShows: AllShows { get }
    var allGenres: AllGenres { get }
}

public enum MainHomeSection {
    public protocol AllMovies: Reducible {}
    public protocol AllShows: Reducible {}
    public protocol AllGenres: Reducible {
        func genreBy(id: Genre.ID) -> Genre
    }
}
