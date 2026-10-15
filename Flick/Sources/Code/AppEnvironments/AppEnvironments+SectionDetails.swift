//
//  AppEnvironments+SectionDetails.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SectionDetails
import API

extension AppEnvironments: SectionDetailsEnvironmentProviding {
    static var sectionDetailsEnvironment: SectionDetailsEnvironment {
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
