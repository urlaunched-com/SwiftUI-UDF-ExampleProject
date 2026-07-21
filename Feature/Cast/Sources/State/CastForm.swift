//
//  CastForm.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF

public struct CastForm: Form {
    public var dialog: DialogStatus = .dismissed

    public init() {}

    public mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.Error:
            dialog = .init(error: action.error)

        default:
            break
        }
    }
}
