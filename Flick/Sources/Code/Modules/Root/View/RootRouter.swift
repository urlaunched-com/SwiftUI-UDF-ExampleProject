//
//  RootRouter.swift
//  Flick
//
//  Created by Alexander Sharko on 11.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

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
        case .onboarding: OnboardingContainer()
        case .signIn: SignInContainer()
        case .home: HomeContainer()
        case .search: SearchContainer()
        case .randomizer: Text("Randomizer")
        case .favorites: MyFavoritesContainer()
        case .profile: SettingsContainer()
        case .tabBar: TabBarContainer()
        }
    }
}
