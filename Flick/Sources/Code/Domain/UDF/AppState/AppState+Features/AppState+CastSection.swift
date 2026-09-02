//
//  AppState+CastSection.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import CastSection
import Common
import NetworkConnectivity

extension AppState: CastSectionFeature {
    typealias AllCast = Flick.AllCast
    typealias CastSectionContainerType = CastSectionContainer<Self>

    struct CastSectionFeatureNavigation: Common.FeatureNavigation {
        typealias Routing = AppRouter.CastSectionRouting
        typealias EntryPoint = CastSectionEntryPoint<AppState>

        let routing: AppRouter.CastSectionRouting

        init(routing: AppRouter.CastSectionRouting) {
            self.routing = routing
        }
    }

    var castSectionBindableFlow: BindableSource<CastSectionTarget, CastSectionFlow> {
        BindableSource(
            reducers: Dictionary(
                uniqueKeysWithValues: castSectionFlow.map { ($0.key, $0.value) }
            )
        )
    }

    var castSectionNavigation: CastSectionFeatureNavigation {
        CastSectionFeatureNavigation(routing: AppRouter.shared.castSectionRouting)
    }
}

extension NetworkConnectivity.NetworkConnectivityForm: CastSection.NetworkConnectivityForm {}
extension Flick.AllCast: CastSection.AllCast {}
