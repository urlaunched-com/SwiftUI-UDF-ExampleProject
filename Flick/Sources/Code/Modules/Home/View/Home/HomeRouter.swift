//
//  HomeRouter.swift
//  Flick
//
//  Created by Alexander Sharko on 18.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

struct HomeRouting: Routing {
    enum Route: Hashable {
        case itemDetails(any Item)
        case sectionDetails(any Section)

        func hash(into hasher: inout Hasher) {
            switch self {
            case let .itemDetails(item):
                hasher.combine(item)
            case let .sectionDetails(section):
                hasher.combine(section)
            }
        }

        static func == (lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
            case let (.itemDetails(lhsItem), .itemDetails(rhsItem)):
                areEqual(lhsItem, rhsItem)
            case let (.sectionDetails(lhsSection), .sectionDetails(rhsSection)):
                areEqual(lhsSection, rhsSection)
            default:
                false
            }
        }
    }

    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case let .itemDetails(item):
            if let movie = item as? Movie {
                MovieDetailsContainer(id: movie.id)
            } else if let show = item as? Show {
                ShowDetailsContainer(id: show.id)
            }

        case let .sectionDetails(section):
            if let movieSection = section as? MovieSection {
                SectionDetailsContainer(section: movieSection)
            } else if let showSection = section as? ShowSection {
                SectionDetailsContainer(section: showSection)
            }
        }
    }
}
