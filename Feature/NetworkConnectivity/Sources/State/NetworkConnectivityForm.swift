//
//  NetworkConnectivityForm.swift
//  Flick
//
//  Created by Alexander Sharko on 04.01.2023.
//

import UDF

public struct NetworkConnectivityForm: Form {
    public var satisfied = true

    public init() {}

    public mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.UpdateNetworkConnectivityStatus:
            satisfied = action.satisfied

        default:
            break
        }
    }
}
