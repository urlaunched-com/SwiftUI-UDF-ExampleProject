//
//  CastEntryPoint.swift
//  Flick
//
//  Created by Bogdan Petkanych on 31.08.2026.
//

import SwiftUI
import Common
import Models
import UDF

public struct CastEntryPoint<F: CastFeature, R: Routing>: FeatureEntryPoint where R.Route == CastRoute {
    public typealias Container = CastContainer<F, R>

    public struct Parameters {
        public let cast: [Cast.ID]

        public init(cast: [Cast.ID]) {
            self.cast = cast
        }
    }

    public static func make(with parameters: Parameters) -> CastContainer<F, R> {
        CastContainer<F, R>(cast: parameters.cast)
    }
}
