//
//  HomeScreenRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Models
import SwiftUI
import UDF

enum HomeScreenRoute: Hashable {
    case mainMovieSection(section: MovieSection, items: [Movie])
    case mainShowSection(section: ShowSection, items: [Show])
    case movieSection(section: MovieSection, items: [Movie])
    case showSection(section: ShowSection, items: [Show])
}

struct HomeScreenRouting<AppState: HomeFeature>: Routing {
    @ViewBuilder func view(for route: HomeScreenRoute) -> some View {
        switch route {
        case let .mainMovieSection(section, items):
            MainHomeSectionContainer<AppState>(section: section, items: items)
        case let .mainShowSection(section, items):
            MainHomeSectionContainer<AppState>(section: section, items: items)
        case let .movieSection(section, items):
            HomeSectionContainer<AppState>(section: section, items: items)
        case let .showSection(section, items):
            HomeSectionContainer<AppState>(section: section, items: items)
        }
    }
}
