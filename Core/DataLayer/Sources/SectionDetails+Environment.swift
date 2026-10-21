//
//  SectionDetails+Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SectionDetails
import API
import MediaModels

public extension SectionDetailsEnvironment {
    static var environment: Self {
        SectionDetailsEnvironment(
            loadMovies: { section, page in
                let movies = try await HomeAPIClient.loadMovies(section: section.urlValue, page: page)
                return movies.map(\.asMovie)
            },
            loadShows: { section, page in
                let shows = try await HomeAPIClient.loadShows(section: section.urlValue, page: page)
                return shows.map(\.asShow)
            }
        )
    }
}
