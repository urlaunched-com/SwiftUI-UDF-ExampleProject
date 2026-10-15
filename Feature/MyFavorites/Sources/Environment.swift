//
//  Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 15.10.26.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Models

public protocol MyFavoritesEnvironmentProviding {
    static var myFavoritesEnvironment: MyFavoritesEnvironment { get }
}

public struct MyFavoritesEnvironment: Sendable {
    var loadMovies: @Sendable (_ page: Int) async throws -> [Movie]
    var loadShows: @Sendable (_ page: Int) async throws -> [Show]

    public init(
        loadMovies: @Sendable @escaping (_ page: Int) async throws -> [Movie],
        loadShows: @Sendable @escaping (_ page: Int) async throws -> [Show]
    ) {
        self.loadMovies = loadMovies
        self.loadShows = loadShows
    }
}
