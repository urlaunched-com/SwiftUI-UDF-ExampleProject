//
//  ImageFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.05.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF

public protocol ImageFeature: AppReducer {
    associatedtype NetworkConnectivityForm: Image.NetworkConnectivityForm

    var imageConfigsForm: ImageConfigsForm { get }
    var imageConfigsFlow: ImageConfigsFlow { get }
    var networkConnectivityForm: NetworkConnectivityForm { get }
}

public enum Image {
    public protocol NetworkConnectivityForm: Form {
        var satisfied: Bool { get }
    }
}
