//
//  NetworkConnectivityForm.swift
//  Flick
//
//  Created by Alexander Sharko on 04.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF

struct NetworkConnectivityForm: Form {
    var satisfied = true

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.UpdateNetworkConnectivityStatus:
            satisfied = action.satisfied

        default:
            break
        }
    }
}
