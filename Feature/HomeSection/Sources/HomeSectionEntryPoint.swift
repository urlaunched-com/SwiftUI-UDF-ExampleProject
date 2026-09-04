//
//  HomeSectionEntryPoint.swift
//  Flick
//
//  Created by Bogdan Petkanych on 31.08.2026.
//

import SwiftUI
import Common
import Models
import UDF

public struct HomeSectionEntryPoint<F: HomeSectionFeature, S: Models.Section, R: Routing>: FeatureEntryPoint where R.Route == HomeSectionRoute {
    public struct Parameters {
        public let section: S
        public let items: [any Item]

        public init(section: S, items: [any Item]) {
            self.section = section
            self.items = items
        }
    }

    public static func make(with parameters: Parameters) -> HomeSectionContainer<F, S, R> {
        HomeSectionContainer<F, S, R>(
            section: parameters.section,
            items: parameters.items
        )
    }
}
