//
//  CastSectionEntryPoint.swift
//  Flick
//
//  Created by Bogdan Petkanych on 31.08.2026.
//

import SwiftUI
import Common
import Models
import UDF

public struct CastSectionEntryPoint<F: CastSectionFeature, R: Routing>: FeatureEntryPoint where R.Route == CastSectionRoute {

    public struct Parameters {
        public let id: CastSectionTarget

        public init(id: CastSectionTarget) {
            self.id = id
        }
    }

    public static func make(with parameters: Parameters) -> CastSectionContainer<F, R> {
        CastSectionContainer<F, R>(id: parameters.id)
    }
}
