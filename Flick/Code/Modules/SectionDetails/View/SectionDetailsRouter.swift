//
//  SectionDetailsRouter.swift
//  Flick
//
//  Created by Alexander Sharko on 19.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

struct SectionDetailsRouting: Routing {
    enum Route: Hashable {
        case itemDetails(any Item)

        func hash(into hasher: inout Hasher) {
            switch self {
            case let .itemDetails(item):
                hasher.combine(item)
            }
        }

        static func == (lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
            case let (.itemDetails(lhsItem), .itemDetails(rhsItem)):
                areEqual(lhsItem, rhsItem)
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
        }
    }
}
