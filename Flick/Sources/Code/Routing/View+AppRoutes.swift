//
//  View+AppRoutes.swift
//  Flick
//
//  Created by Maksym Horobets on 22.10.2026.
//  © 2026 You are launched
//

import HomeModule
import ItemDetailsModule
import ReviewsModule
import SwiftUI
import UDF

extension View {
    /// Registers every flow's screens and links on a tab's navigation stack, so a push or a deep link
    /// resolves on whichever tab it lands.
    func appRoutes() -> some View {
        self
            .navigationDestinations(for: HomeFeatureState<AppState, HomeRouting>.self)
            .navigationDestinations(for: ItemDetailsFeatureState<AppState, ItemDetailsRouting>.self)
            .navigationDestinations(for: ReviewsFeatureState<AppState, ReviewsRouting>.self)
    }
}
