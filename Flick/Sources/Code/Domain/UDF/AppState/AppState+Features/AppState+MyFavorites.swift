//
//  AppState+MyFavorites.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import MyFavorites
import NetworkConnectivity

extension AppState: MyFavoritesFeature {}
extension NetworkConnectivity.NetworkConnectivityForm: MyFavorites.NetworkConnectivityForm {}
