//
//  MoviesStorage.swift
//  Flick
//
//  Created by Alexander Sharko on 01.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import Foundation
import UDF
import UDFMacros
@preconcurrency import SectionsModels
@preconcurrency import MediaModels

@Storage(Movie.self)
@StorageRelationships(
    .hasMany(MovieSection.self, name: "moviesBySectionId", label: "section"),
    .hasMany(Movie.self, name: "recommendationsByMovieId", label: "recommendationsFor")
)
struct AllMovies: Storage {}
