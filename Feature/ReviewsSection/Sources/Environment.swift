//
//  Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import MediaModels
import ReviewModels

public protocol ReviewsSectionEnvironmentProviding {
    static var reviewsSectionEnvironment: ReviewsSectionEnvironment { get }
}

public struct ReviewsSectionEnvironment: Sendable {
    var loadShowReviews: @Sendable (_ showID: Show.ID, _ page: Int) async throws -> [Review]
    var loadMovieReviews: @Sendable (_ movieID: Movie.ID, _ page: Int) async throws -> [Review]

    public init(
        loadShowReviews: @Sendable @escaping (_ showID: Show.ID, _ page: Int) async throws -> [Review],
        loadMovieReviews: @Sendable @escaping (_ movieID: Movie.ID, _ page: Int) async throws -> [Review]
    ) {
        self.loadShowReviews = loadShowReviews
        self.loadMovieReviews = loadMovieReviews
    }
}
