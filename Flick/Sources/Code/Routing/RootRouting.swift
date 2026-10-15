//
//  RootRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//

import Common
import Home
import ItemDetails
import Reviews
import Root
import SwiftUI
import UDF

struct RootRouting: Routing {
    @ViewBuilder func view(for route: RootRoute) -> some View {
        switch route {
        case .onboarding:
            AppRouter.onboarding()
        case .signIn:
            AppRouter.signIn()
        case .home:
            AppRouter.home()
                .navigationDestinations(for: HomeFeatureState<AppState, HomeRouting>.self)
                .navigationDestinations(for: ItemDetailsFeatureState<AppState, ItemDetailsRouting>.self)
                .navigationDestinations(for: ReviewsFeatureState<AppState, ReviewsRouting>.self)
        case .search:
            AppRouter.search()
        case .randomizer:
            Text("Randomizer")
        case .favorites:
            AppRouter.myFavorites()
        case .profile:
            AppRouter.settings()
        }
    }
}
