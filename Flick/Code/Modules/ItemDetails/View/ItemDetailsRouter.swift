//
//  ItemDetailsRouter.swift
//  Flick
//
//  Created by Alexander Sharko on 20.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

struct ItemDetailsRouting: Routing {
    enum Route: Hashable {
        case cast(any Item)
        case reviews(any Item)
        case recommendations(any Item)
        case whereToWatch(any Item)

        func hash(into hasher: inout Hasher) {
            switch self {
            case let .cast(item):
                hasher.combine(item)
            case let .reviews(item):
                hasher.combine(item)
            case let .recommendations(item):
                hasher.combine(item)
            case let .whereToWatch(item):
                hasher.combine(item)
            }
        }

        static func == (lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
            case let (.cast(lhsItem), .cast(rhsItem)):
                areEqual(lhsItem, rhsItem)
            case let (.reviews(lhsItem), .reviews(rhsItem)):
                areEqual(lhsItem, rhsItem)
            case let (.recommendations(lhsItem), .recommendations(rhsItem)):
                areEqual(lhsItem, rhsItem)
            case let (.whereToWatch(lhsItem), .whereToWatch(rhsItem)):
                areEqual(lhsItem, rhsItem)
            default:
                false
            }
        }
    }

    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        case let .cast(item):
            buildView(
                item: item,
                movieView: { MovieCastContainer(id: $0.id) },
                showView: { ShowCastContainer(id: $0.id) }
            )

        case let .reviews(item):
            buildView(
                item: item,
                movieView: { MovieDetailsReviewsContainer(id: $0.id) },
                showView: { ShowDetailsReviewsContainer(id: $0.id) }
            )

        case let .recommendations(item):
            buildView(
                item: item,
                movieView: { MovieDetailsRecommendationsContainer(id: $0.id) },
                showView: { ShowDetailsRecommendationsContainer(id: $0.id) }
            )

        case let .whereToWatch(item):
            WhereToWatchContainer(item: item)
        }
    }
}
