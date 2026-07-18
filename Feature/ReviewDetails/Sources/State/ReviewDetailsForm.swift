//
//  ReviewDetailsForm.swift
//  Flick
//
//  Created by Bogdan Petkanych on 18.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF

public struct ReviewDetailsForm: Form {
    var dialog: DialogStatus = .dismissed
    
    public init() {}

    public mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.Error where action.id == ReviewDetailsFlow.id:
            dialog = .init(error: action.error)

        default:
            break
        }
    }
}
