//
//  MainHomeSectionEntryPoint.swift
//  Flick
//
//  Created by Bogdan Petkanych on 31.08.2026.
//

import SwiftUI
import Common
import Models
import UDF

public struct MainHomeSectionEntryPoint<F: MainHomeSectionFeature, S: Models.Section, R: Routing>: FeatureEntryPoint where R.Route == MainHomeSectionRoute {
    public struct Parameters {
        public let section: S
        public let items: [any Item]

        public init(section: S, items: [any Item]) {
            self.section = section
            self.items = items
        }
    }

    public static func make(with parameters: Parameters) -> MainHomeSectionContainer<F, S, R> {
        MainHomeSectionContainer<F, S, R>(
            section: parameters.section,
            items: parameters.items
        )
    }
}
