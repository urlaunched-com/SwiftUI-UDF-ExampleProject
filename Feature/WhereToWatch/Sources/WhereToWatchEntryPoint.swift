//
//  WhereToWatchEntryPoint.swift
//  Flick
//
//  Created by Bogdan Petkanych on 31.08.2026.
//

import SwiftUI
import Common
import Models
import UDF

public struct WhereToWatchEntryPoint<F: WhereToWatchFeature, R: Routing>: FeatureEntryPoint where R.Route == WhereToWatchRouter {
    public struct Parameters {
        public let item: any Item

        public init(item: any Item) {
            self.item = item
        }
    }

    public static func make(with parameters: Parameters) -> WhereToWatchContainer<F, R> {
        WhereToWatchContainer<F, R>(item: parameters.item)
    }
}
