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

struct RootRouting: Routing {
    @ViewBuilder func view(for route: RootRoute) -> some View {
        switch route {
        case .onboarding:
            OnboardingContainer<AppState>()
        case .signIn:
            SignInContainer<AppState, SignInRouting>()
        case .home:
            HomeContainer<AppState, HomeRouting>()
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
