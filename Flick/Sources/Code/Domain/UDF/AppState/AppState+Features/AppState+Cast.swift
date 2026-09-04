//
//  AppState+Cast.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Cast
import Common

extension AppState: CastFeature {

    struct CastFeatureNavigation: Common.FeatureNavigation {
        typealias EntryPoint = CastEntryPoint<AppState>
        let routing: AppRouter.CastRouting
        
        init(routing: AppRouter.CastRouting) {
            self.routing = routing
        }
    }
    
    var castNavigation: CastFeatureNavigation {
        CastFeatureNavigation(routing: AppRouter.shared.castRouting)
    }
}
