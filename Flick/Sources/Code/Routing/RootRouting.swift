//
//  RootRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//

import Home
import MyFavorites
import Onboarding
import Root
import Search
import Settings
import SignIn
import SwiftUI
import TabBar
import UDF
import Common

struct RootRouting: Routing {
    @ViewBuilder func view(for route: RootRoute) -> some View {
        switch route {
        case .onboarding:
            AppRouter.onboarding()
        case .signIn:
            SignInFeatureState<AppState, SignInRouting>.entryPoint()
        case .home:
            AppRouter.home()
                .navigationDestination(for: HomeRouting.self)
                .navigationDestination(for: MainHomeSectionRouting.self)
                .navigationDestination(for: HomeSectionRouting.self)
                .navigationDestination(for: SectionDetailsRouting.self)
                .navigationDestination(for: ItemDetailsRouting.self)
                .navigationDestination(for: ReviewsRouting.self)
                .navigationDestination(for: ReviewsSectionRouting.self)
                .navigationDestination(for: RecommendationsSectionRouting.self)
                .navigationDestination(for: ReviewsRouting.self)
                .navigationDestination(for: CastSectionRouting.self)
                .navigationDestination(for: RecommendationsRouting.self)
        case .search:
            SearchFeatureState<AppState, SearchRouting>.entryPoint()
        case .randomizer:
            Text("Randomizer")
        case .favorites:
            AppRouter.myFavorites()
        case .profile:
            AppRouter.settings()
        case .tabBar:
            AppRouter.tabBar()
        }
    }
}
