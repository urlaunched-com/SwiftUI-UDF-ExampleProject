//
//  ItemDetails+Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import ItemDetails
import API
import MediaModels

public extension ItemDetailsEnvironment {
    static var environment: Self {
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
