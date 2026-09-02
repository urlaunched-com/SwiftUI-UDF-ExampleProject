//
//  AppState+MyFavorites.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import MyFavorites
import NetworkConnectivity
import Common

extension AppState: MyFavoritesFeature {
    struct MyFavoritesFeatureNavigation: Common.FeatureNavigation {
        typealias Routing = MyFavoritesRouting
        typealias EntryPoint = MyFavoritesEntryPoint<AppState>

        let routing: MyFavoritesRouting
    }

    var myFavoritesNavigation: MyFavoritesFeatureNavigation {
        .init(routing: AppRouter.shared.myFavoritesRouting)
    }
}
extension NetworkConnectivity.NetworkConnectivityForm: MyFavorites.NetworkConnectivityForm {}
