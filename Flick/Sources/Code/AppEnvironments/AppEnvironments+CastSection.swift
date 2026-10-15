//
//  AppEnvironments+CastSection.swift
//  Flick
//
//  Created by Bogdan Petkanych on 15.10.26.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import CastSection
import API
import CastModels

extension AppEnvironments: CastSectionEnvironmentProviding {
    static var castSectionEnvironment: CastSectionEnvironment {
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
