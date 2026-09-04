//
//  SectionDetailsEntryPoint.swift
//  Flick
//
//  Created by Bogdan Petkanych on 31.08.2026.
//

import SwiftUI
import Common
import Models
import UDF

public struct SectionDetailsEntryPoint<F: SectionDetailsFeature, S: Models.Section, R: Routing>: FeatureEntryPoint where R.Route == SectionDetailsRoute {
    public struct Parameters {
        public let section: S

        public init(section: S) {
            self.section = section
        }
    }

    public static func make(with parameters: Parameters) -> SectionDetailsContainer<F, S, R> {
        SectionDetailsContainer<F, S, R>(section: parameters.section)
    }
}
