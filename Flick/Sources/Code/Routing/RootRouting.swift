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
            OnboardingContainer<AppState>()
        case .signIn:
            SignInContainer<AppState, SignInRouting>()
        case .home:
            HomeContainer<AppState, HomeRouting>()
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
        case .search:
            SearchContainer<AppState, SearchRouting>()
        case .randomizer:
            Text("Randomizer")
        case .favorites:
            MyFavoritesContainer<AppState, MyFavoritesRouting>()
        case .profile:
            SettingsContainer<AppState>()
        case .tabBar:
            TabBarContainer<AppState>()
        }
    }
}

