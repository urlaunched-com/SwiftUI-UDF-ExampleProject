//
//  Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Models

public protocol SectionDetailsEnvironmentProviding {
    static var sectionDetailsEnvironment: SectionDetailsEnvironment { get }
}

public struct SectionDetailsEnvironment: Sendable {
    var loadMovies: @Sendable (_ section: MovieSection.ID, _ page: Int) async throws -> [Movie]
    var loadShows: @Sendable (_ section: ShowSection.ID, _ page: Int) async throws -> [Show]

    public init(
        loadMovies: @Sendable @escaping (_ section: MovieSection.ID, _ page: Int) async throws -> [Movie],
        loadShows: @Sendable @escaping (_ section: ShowSection.ID, _ page: Int) async throws -> [Show]
    ) {
        self.loadMovies = loadMovies
        self.loadShows = loadShows
    }
}
