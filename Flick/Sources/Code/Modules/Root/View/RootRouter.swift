//
//  RootRouter.swift
//  Flick
//
//  Created by Alexander Sharko on 11.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import SignIn
import Onboarding
import Search
import MyFavorites
import Settings
import Home

struct RootRouting: Routing {
    enum Route {
        case onboarding
        case signIn
        case home
        case search
        case randomizer
        case favorites
        case profile
        case tabBar
    }

    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .onboarding: OnboardingContainer<AppState>()
        case .signIn: SignInContainer<AppState, SignInRouting>()
        case .home: HomeContainer<AppState, HomeRouting>()
        case .search: SearchContainer<AppState, SearchRouting>()
        case .randomizer: Text("Randomizer")
        case .favorites: MyFavoritesContainer<AppState, MyFavoritesRouting>()
        case .profile: SettingsContainer<AppState>()
        case .tabBar: TabBarContainer()
        }
    }
}
