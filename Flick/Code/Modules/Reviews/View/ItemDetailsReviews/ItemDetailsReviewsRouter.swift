//
//  ItemDetailsReviewsRouter.swift
//  Flick
//
//  Created by Alexander Sharko on 08.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

struct ItemDetailsReviewsRouting: Routing {
    enum Route: Hashable {
        case reviewDetails(Review.ID)
        case reviews(any Item)

        func hash(into hasher: inout Hasher) {
            switch self {
            case let .reviewDetails(id):
                hasher.combine(id)
            case let .reviews(item):
                hasher.combine(item)
            }
        }

        static func == (lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
            case let (.reviewDetails(lhsId), .reviewDetails(rhsId)):
                areEqual(lhsId, rhsId)
            case let (.reviews(lhsItem), .reviews(rhsItem)):
                areEqual(lhsItem, rhsItem)
            default:
                false
            }
        }
    }

    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case let .reviewDetails(id):
            ReviewDetailsContainer(reviewId: id)
        case let .reviews(item):
            if let movie = item as? Movie {
                MovieReviewsContainer(id: movie.id)
            } else if let show = item as? Show {
                ShowReviewsContainer(id: show.id)
            }
        }
    }
}
