//
//  AppState+ItemDetails.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import ItemDetailsModule
import NetworkConnectivityModule

extension AppState: ItemDetailsFeature {
    typealias AllCast = Flick.AllCast
}

extension NetworkConnectivityModule.NetworkConnectivityForm: ItemDetails.NetworkConnectivityForm {}
extension AllMovies: ItemDetails.AllMovies {}
extension AllShows: ItemDetails.AllShows {}
extension AllCast: ItemDetails.AllCast {}
