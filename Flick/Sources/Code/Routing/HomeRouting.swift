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
            MainHomeSectionContainer<AppState, MovieSection, MainHomeSectionRouting>(
                section: section,
                items: items
            )
        case let .mainShowSection(section, items):
            MainHomeSectionContainer<AppState, ShowSection, MainHomeSectionRouting>(
                section: section,
                items: items
            )
        case let .movieSection(section, items):
            HomeSectionContainer<AppState, MovieSection, HomeSectionRouting>(
                section: section,
                items: items
            )
        case let .showSection(section, items):
            HomeSectionContainer<AppState, ShowSection, HomeSectionRouting>(
                section: section,
                items: items
            )
        }
    }
}
