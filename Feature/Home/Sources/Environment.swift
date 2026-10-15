//
//  Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 15.10.26.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Models
import SectionsModels

public protocol HomeEnvironmentProviding {
    static var homeEnvironment: HomeEnvironment { get }
    static var homeGenresEnvironment: HomeGenresEnvironment { get }
}

public struct HomeEnvironment: Sendable {
    var loadMovies: @Sendable (_ section: MovieSection.ID) async throws -> [Movie]
    var loadShows: @Sendable (_ section: ShowSection.ID) async throws -> [Show]

    public init(
        loadMovies: @Sendable @escaping (_ section: MovieSection.ID) async throws -> [Movie],
        loadShows: @Sendable @escaping (_ section: ShowSection.ID) async throws -> [Show]
    ) {
        self.loadMovies = loadMovies
        self.loadShows = loadShows
    }
}

public struct HomeGenresEnvironment: Sendable {
    var loadMovieGenres: @Sendable () async throws -> [Genre]
    var loadShowGenres: @Sendable () async throws -> [Genre]

    public init(
        loadMovieGenres: @Sendable @escaping () async throws -> [Genre],
        loadShowGenres: @Sendable @escaping () async throws -> [Genre]
    ) {
        self.loadMovieGenres = loadMovieGenres
        self.loadShowGenres = loadShowGenres
    }
}
