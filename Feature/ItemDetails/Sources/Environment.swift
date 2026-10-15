//
//  Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 15.10.26.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import MediaModels

public protocol ItemDetailsEnvironmentProviding {
    static var itemDetailsEnvironment: ItemDetailsEnvironment { get }
}

public struct ItemDetailsEnvironment: Sendable {
    var loadMovieDetails: @Sendable (_ movieID: Movie.ID) async throws -> Movie
    var loadShowDetails: @Sendable (_ showID: Show.ID) async throws -> Show

    public init(
        loadMovieDetails: @Sendable @escaping (_ movieID: Movie.ID) async throws -> Movie,
        loadShowDetails: @Sendable @escaping (_ showID: Show.ID) async throws -> Show
    ) {
        self.loadMovieDetails = loadMovieDetails
        self.loadShowDetails = loadShowDetails
    }
}
