//
//  AppState+Home.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Home
import NetworkConnectivity

extension AppState: HomeFeature {
    typealias NetworkConnectivityForm = NetworkConnectivity.NetworkConnectivityForm
    typealias AllMovies = Flick.AllMovies
    typealias AllShows = Flick.AllShows
    typealias AllGenres = Flick.AllGenres
}

extension NetworkConnectivity.NetworkConnectivityForm: HomeFeatureTypes.NetworkConnectivityForm {}
extension AllMovies: HomeFeatureTypes.AllMovies {}
extension AllShows: HomeFeatureTypes.AllShows {}
