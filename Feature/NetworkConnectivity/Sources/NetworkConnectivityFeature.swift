//
//  NetworkConnectivityFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//

import UDF

public protocol NetworkConnectivityFeature: AppReducer {
    var networkConnectivityForm: NetworkConnectivityForm { get }
}
