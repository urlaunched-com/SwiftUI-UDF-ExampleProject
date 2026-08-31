//
//  MyFavoritesEntryPoint.swift
//  Flick
//
//  Created by Bogdan Petkanych on 31.08.2026.
//

import SwiftUI
import Common
import Models
import UDF

public struct MyFavoritesEntryPoint<F: MyFavoritesFeature, R: Routing>: FeatureEntryPoint where R.Route == MyFavoritesRoute {

    public struct Parameters {
        public init() {}
    }

    public static func make(with parameters: Parameters) -> MyFavoritesContainer<F, R> {
        MyFavoritesContainer<F, R>()
    }
}
