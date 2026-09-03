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
            OnboardingEntryPoint<AppState>.make(with: .init())
        case .signIn:
            SignInEntryPoint<AppState>.make(with: .init())
        case .home:
            HomeEntryPoint<AppState, HomeRouting>.make(with: .init())
                .navigationDestination(for: HomeRouting.self)
                .navigationDestination(for: MainHomeSectionRouting.self)
                .navigationDestination(for: HomeSectionRouting.self)
                .navigationDestination(for: SectionDetailsRouting.self)
                .navigationDestination(for: ItemDetailsRouting.self)
                .navigationDestination(for: ReviewsRouting.self)
                .navigationDestination(for: ReviewsSectionRouting.self)
                .navigationDestination(for: RecommendationsSectionRouting.self)
                .navigationDestination(for: ReviewsRouting.self)
                .navigationDestination(for: AppRouter.CastSectionRouting.self)
        case .search:
            SearchEntryPoint<AppState>.make(with: .init())
        case .randomizer:
            Text("Randomizer")
        case .favorites:
            MyFavoritesEntryPoint<AppState>.make(with: .init())
        case .profile:
            SettingsEntryPoint<AppState>.make(with: .init())
        case .tabBar:
            TabBarEntryPoint<AppState>.make(with: .init())
        }
    }
}
