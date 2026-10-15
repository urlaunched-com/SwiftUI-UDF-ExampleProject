//
//  ItemDetailsForm.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF
@preconcurrency import Models

public struct ItemDetailsForm: Form {
    var dialog: DialogStatus = .dismissed
    
    public init() {}

    public mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.Error where action.id == ItemDetailsFlow.id:
            dialog = .init(error: action.error)

        default:
            break
        }
    }
}
