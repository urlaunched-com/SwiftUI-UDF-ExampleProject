//
//  ImageConfigsFlow.swift
//  Flick
//
//  Created by Alexander Sharko on 03.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF
import Models

public enum ImageConfigsFlow: IdentifiableFlow {
    case none
    case loading

    public init() {
        self = .loading
    }

    public mutating func reduce(_ action: some Action) {
        switch action {
        case is Actions.DidLoadItem<ImageConfigs>:
            self = .none

        default:
            break
        }
    }
}
