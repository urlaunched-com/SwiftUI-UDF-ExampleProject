//
//  SearchEntryPoint.swift
//  Flick
//
//  Created by Bogdan Petkanych on 31.08.2026.
//

import SwiftUI
import Common
import UDF

public struct SearchEntryPoint<F: SearchFeature>: FeatureEntryPoint {
    public struct Parameters {
        public init() {}
    }

    public static func make(with parameters: Parameters) -> SearchContainer<F> {
        SearchContainer<F>()
    }
}
