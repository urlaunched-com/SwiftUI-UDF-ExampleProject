//
//  AppState+MyFavorites.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import MyFavorites
import NetworkConnectivity

extension AppState: MyFavoritesFeature {
    typealias AllGenres = Flick.AllGenres
}

extension AllMovies: MyFavorites.AllMovies {}
extension AllShows: MyFavorites.AllShows {}
extension AllGenres: MyFavorites.AllGenres {}
extension NetworkConnectivity.NetworkConnectivityForm: MyFavorites.NetworkConnectivityForm {}
