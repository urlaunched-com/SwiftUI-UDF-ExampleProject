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
    typealias ItemDetailsContainerType = ItemDetailsContainer<Self, ItemDetailsRouting>
    
    var itemDetailsBindableFlow: BindableSource<ItemDetailsTarget, ItemDetailsFlow> {
        BindableSource(
            reducers: Dictionary(
                uniqueKeysWithValues: itemDetailFlow.map { ($0.key, $0.value) }
            )
        )
    }
    
    var itemDetailsBindableForm: BindableSource<ItemDetailsTarget, ItemDetailsForm> {
        BindableSource(
            reducers: Dictionary(
                uniqueKeysWithValues: itemDetailForm.map { ($0.key, $0.value) }
            )
        )
    }
}

extension NetworkConnectivity.NetworkConnectivityForm: ItemDetails.NetworkConnectivityForm {}
