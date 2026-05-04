//
//  ImageConfigsForm.swift
//  Flick
//
//  Created by Alexander Sharko on 03.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Foundation
import UDF

struct ImageConfigsForm: Form {
    var configs: ImageConfigs = .basic

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.DidLoadItem<ImageConfigs>:
            configs = action.item

        default:
            break
        }
    }
}
