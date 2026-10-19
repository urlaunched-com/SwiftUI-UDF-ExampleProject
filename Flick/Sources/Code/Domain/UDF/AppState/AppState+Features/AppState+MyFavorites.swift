//
//  AppState+MyFavorites.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import MyFavoritesModule
import NetworkConnectivityModule
import Common

extension AppState: MyFavoritesFeature {}
extension NetworkConnectivityModule.NetworkConnectivityForm: MyFavorites.NetworkConnectivityForm {}
