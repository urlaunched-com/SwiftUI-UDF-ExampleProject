//
//  AppState+ItemDetails.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import ItemDetails
import Common
import NetworkConnectivity

extension AppState: ItemDetailsFeature {
    typealias ItemDetailsFeatureRouting = ItemDetailsRouting
    typealias ItemDetailsEnvironment = AppEnvironments
}

extension NetworkConnectivity.NetworkConnectivityForm: ItemDetails.NetworkConnectivityForm {}
