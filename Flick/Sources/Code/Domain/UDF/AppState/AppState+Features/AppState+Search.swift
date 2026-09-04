//
//  AppState+Search.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Search
import NetworkConnectivity
import Common

extension AppState: SearchFeature {
    typealias AllSearchItems = Flick.AllSearchItems

    struct SearchFeatureNavigation: Common.FeatureNavigation {
        typealias Routing = SearchRouting
        typealias EntryPoint = SearchEntryPoint<AppState>

        let routing: SearchRouting
    }

    var searchNavigation: SearchFeatureNavigation {
        .init(routing: AppRouter.shared.searchRouting)
    }
}
extension NetworkConnectivity.NetworkConnectivityForm: Search.NetworkConnectivityForm {}
