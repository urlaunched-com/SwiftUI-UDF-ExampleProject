//
//  AppState+Search.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SearchModule
import NetworkConnectivityModule

extension AppState: SearchFeature {
    typealias AllSearchItems = Flick.AllSearchItems
}
extension NetworkConnectivityModule.NetworkConnectivityForm: Search.NetworkConnectivityForm {}
