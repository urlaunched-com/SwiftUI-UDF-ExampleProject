//
//  RootRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//

import RootModule
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
                .appRoutes()
        case .search:
            AppRouter.search()
                .appRoutes()
        case .randomizer:
            Text("Randomizer")
                .appRoutes()
        case .favorites:
            AppRouter.myFavorites()
                .appRoutes()
        case .profile:
            AppRouter.settings()
                .appRoutes()
        }
    }
}
