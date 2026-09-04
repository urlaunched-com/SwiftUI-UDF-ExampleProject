//
//  AppState+WhereToWatch.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import WhereToWatch
import Home
import Common

extension AppState: WhereToWatchFeature {
    struct WhereToWatchFeatureNavigation: Common.FeatureNavigation {
        typealias Routing = WhereToWatchRouting
        typealias EntryPoint = WhereToWatchEntryPoint<AppState>

        let routing: WhereToWatchRouting
    }

    var whereToWatchNavigation: WhereToWatchFeatureNavigation {
        .init(routing: AppRouter.shared.whereToWatchRouting)
    }
}

extension Home.HomeFlow: WhereToWatch.HomeFlow {}
