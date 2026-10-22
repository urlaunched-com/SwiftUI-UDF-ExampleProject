//
//  Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 15.10.26.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import MediaModels

public protocol RecommendationsEnvironmentProviding {
    static var recommendationsEnvironment: RecommendationsEnvironment { get }
}

public struct RecommendationsEnvironment: Sendable {
    var loadMovies: @Sendable (_ movieID: Movie.ID, _ page: Int) async throws -> [Movie]
    var loadShows: @Sendable (_ showID: Show.ID, _ page: Int) async throws -> [Show]

    public init(
        loadMovies: @Sendable @escaping (_ movieID: Movie.ID, _ page: Int) async throws -> [Movie],
        loadShows: @Sendable @escaping (_ showID: Show.ID, _ page: Int) async throws -> [Show]
    ) {
        self.loadMovies = loadMovies
        self.loadShows = loadShows
    }
}
