//
//  AppState+MyFavorites.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import DataLayer
import MyFavorites
import NetworkConnectivity
import Common

extension AppState: MyFavoritesFeature {
    typealias MyFavoritesEnvironment = FlickEnvironments
}
extension NetworkConnectivity.NetworkConnectivityForm: MyFavorites.NetworkConnectivityForm {}
