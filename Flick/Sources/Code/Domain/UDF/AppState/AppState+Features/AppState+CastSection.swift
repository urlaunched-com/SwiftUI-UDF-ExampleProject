//
//  AppState+CastSection.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import CastSection
import Common

extension AppState: CastSectionFeature {
    typealias CastSectionContainerType = CastSectionContainer<Self, CastSectionRouting>
    typealias AllCast = Flick.AllCast

    var castSectionBindableFlow: BindableSource<CastSectionTarget, CastSectionFlow> {
        BindableSource(
            reducers: Dictionary(
                uniqueKeysWithValues: castSectionFlow.map { ($0.key, $0.value) }
            )
        )
    }
}

extension NetworkConnectivityForm: CastSection.NetworkConnectivityForm {}
extension AllCast: CastSection.AllCast {}
