//
//  AppState+Search.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Search

extension AppState: SearchFeature {
    typealias AllSearchItems = Flick.AllSearchItems
}

extension AllSearchItems: Search.AllSearchItems {}
extension NetworkConnectivityForm: Search.NetworkConnectivityForm {}
