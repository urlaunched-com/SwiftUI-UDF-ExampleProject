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
}

extension NetworkConnectivity.NetworkConnectivityForm: CastSection.NetworkConnectivityForm {}
extension Flick.AllCast: CastSection.AllCast {}
