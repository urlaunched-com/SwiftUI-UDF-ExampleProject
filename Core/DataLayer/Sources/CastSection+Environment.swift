//
//  CastSection+Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import CastSection
import API
import CastModels

public extension CastSectionEnvironment {
    static var environment: Self {
        CastSectionEnvironment(
            loadMovieCast: { movieID in
                try await ItemDetailsAPIClient.loadMovieCast(movieId: movieID.value).map(\.asCast)
            },
            loadShowCast: { showID in
                try await ItemDetailsAPIClient.loadShowCast(showId: showID.value).map(\.asCast)
            }
        )
    }
}
