//
//  HomeRouting.swift
//  Flick
//
//  Created by Alexander Sharko on 18.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Common
import Models
import Home
import HomeSection
import MainHomeSection

struct HomeRouting: Routing {
    typealias Route = HomeRoute

    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case let .mainMovieSection(section, items):
            MainHomeSectionEntryPoint<AppState, MovieSection, MainHomeSectionRouting>.make(
                with: .init(section: section, items: items)
            )
        case let .mainShowSection(section, items):
            MainHomeSectionEntryPoint<AppState, ShowSection, MainHomeSectionRouting>.make(
                with: .init(section: section, items: items)
            )
        case let .movieSection(section, items):
            AppRouter.homeSection(section: section, items: items)
        case let .showSection(section, items):
            AppRouter.homeSection(section: section, items: items)
        }
    }
}
