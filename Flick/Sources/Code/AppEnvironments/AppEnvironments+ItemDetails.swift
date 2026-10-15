//
//  AppEnvironments+ItemDetails.swift
//  Flick
//
//  Created by Bogdan Petkanych on 15.10.26.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import ItemDetails
import API

extension AppEnvironments: ItemDetailsEnvironmentProviding {
    static var itemDetailsEnvironment: ItemDetailsEnvironment {
        ItemDetailsEnvironment(
            loadMovieDetails: { movieID in
                try await ItemDetailsAPIClient.loadMovie(movieId: movieID.value).asMovie
            },
            loadShowDetails: { showID in
                try await ItemDetailsAPIClient.loadShow(showId: showID.value).asShow
            }
        )
    }
}
