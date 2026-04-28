//
//  ShowDetailsForm.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF

struct ShowDetailsForm: Form {
    var alert: AlertBuilder.AlertStatus = .dismissed
    var showId: Show.ID?

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.Error where action.id == ShowDetailsFlow.id:
            alert = .init(error: action.error)

        default:
            break
        }
    }
}
