//
//  ImageConfigsForm.swift
//  Flick
//
//  Created by Alexander Sharko on 03.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Foundation
import UDF
@preconcurrency import Models

public struct ImageConfigsForm: Form {
    public var configs: ImageConfigs = .basic

    public init() {}

    public mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.DidLoadItem<ImageConfigs>:
            configs = action.item

        default:
            break
        }
    }
}
