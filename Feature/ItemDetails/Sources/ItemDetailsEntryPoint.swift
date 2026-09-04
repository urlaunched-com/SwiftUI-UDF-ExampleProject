//
//  ItemDetailsEntryPoint.swift
//  Flick
//
//  Created by Bogdan Petkanych on 31.08.2026.
//

import SwiftUI
import Common
import Models
import UDF

public struct ItemDetailsEntryPoint<F: ItemDetailsFeature, R: Routing>: FeatureEntryPoint where R.Route == ItemDetailsRoute {

    public struct Parameters {
        public let id: ItemDetailsTarget

        public init(id: ItemDetailsTarget) {
            self.id = id
        }
    }

    public static func make(with parameters: Parameters) -> ItemDetailsContainer<F, R> {
        ItemDetailsContainer<F, R>(id: parameters.id)
    }
}
