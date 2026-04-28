//
//  CastForm.swift
//  Flick
//
//  Created by Alexander Sharko on 19.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF

struct CastForm: Form {
    var dialog: DialogStatus = .dismissed

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.Error
            where action.id == MovieCastFlow.id || action.id == ShowCastFlow.id:
            dialog = .init(error: action.error)

        default:
            break
        }
    }
}
