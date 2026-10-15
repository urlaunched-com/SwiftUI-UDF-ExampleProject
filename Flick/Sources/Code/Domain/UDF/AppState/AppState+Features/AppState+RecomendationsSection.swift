//
//  AppState+RecomendationsSection.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import RecommendationsSection
import Common
import Models
import NetworkConnectivity

extension AppState: RecommendationsSectionFeature {
    typealias RecommendationsSectionEnvironment = AppEnvironments
    typealias RecommendationsSectionRouting = Flick.RecommendationsSectionRouting
}

extension NetworkConnectivity.NetworkConnectivityForm: RecommendationsSection.NetworkConnectivityForm {}
extension AllShows: RecommendationsSection.AllShows {}
extension AllMovies: RecommendationsSection.AllMovies {}
extension AllGenres: RecommendationsSection.AllGenres {}
