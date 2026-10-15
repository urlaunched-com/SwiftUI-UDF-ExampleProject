//
//  Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 15.10.26.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Models
import CastModels

public protocol CastSectionEnvironmentProviding {
    static var castSectionEnvironment: CastSectionEnvironment { get }
}

public struct CastSectionEnvironment: Sendable {
    var loadMovieCast: @Sendable (_ movieID: Movie.ID) async throws -> [Cast]
    var loadShowCast: @Sendable (_ showID: Show.ID) async throws -> [Cast]

    public init(
        loadMovieCast: @Sendable @escaping (_ movieID: Movie.ID) async throws -> [Cast],
        loadShowCast: @Sendable @escaping (_ showID: Show.ID) async throws -> [Cast]
    ) {
        self.loadMovieCast = loadMovieCast
        self.loadShowCast = loadShowCast
    }
}
