//
//  AppState+Search.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import DataLayer
import Search
import NetworkConnectivity

extension AppState: SearchFeature {
    typealias AllSearchItems = Flick.AllSearchItems
    typealias SearchEnvironment = FlickEnvironments
}
extension NetworkConnectivity.NetworkConnectivityForm: Search.NetworkConnectivityForm {}
