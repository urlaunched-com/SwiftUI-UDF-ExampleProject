//
//  RootScreenRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUI
import UDF

enum RootScreenRoute: Hashable {
    case onboarding
    case signIn
    case home
    case search
    case randomizer
    case favorites
    case profile
    case tabBar
}

struct RootScreenRouting<AppState: RootFeature>: Routing {
    @ViewBuilder func view(for route: RootScreenRoute) -> some View {
        switch route {
        case .tabBar:
            TabBarContainer<AppState>()
        case .onboarding:
            AppState.RootRouting().view(for: .onboarding)
        case .signIn:
            AppState.RootRouting().view(for: .signIn)
        case .home:
            AppState.RootRouting().view(for: .home)
        case .search:
            AppState.RootRouting().view(for: .search)
        case .randomizer:
            AppState.RootRouting().view(for: .randomizer)
        case .favorites:
            AppState.RootRouting().view(for: .favorites)
        case .profile:
            AppState.RootRouting().view(for: .profile)
        }
    }
}
