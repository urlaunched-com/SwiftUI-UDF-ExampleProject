//
//  AppState+Recommendations.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Recommendations
import Models
import NetworkConnectivity

extension AppState: RecommendationsFeature {
    typealias RecommendationsAllGenres = Flick.AllGenres
    typealias RecommendationsAllMovies = Flick.AllMovies
    typealias RecommendationsAllShows = Flick.AllShows
}

extension NetworkConnectivity.NetworkConnectivityForm: Recommendations.NetworkConnectivityForm {}
extension Flick.AllShows: Recommendations.AllShows {}
extension Flick.AllMovies: Recommendations.AllMovies {}
extension Flick.AllGenres: Recommendations.AllGenres {}
