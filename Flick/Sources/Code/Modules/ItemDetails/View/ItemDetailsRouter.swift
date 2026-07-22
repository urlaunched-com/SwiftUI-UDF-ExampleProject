//
//  ItemDetailsRouter.swift
//  Flick
//
//  Created by Alexander Sharko on 20.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Models
import Common
import WhereToWatch
import ItemDetailsComponent
import ReviewsSection
import RecommendationsSection

struct ItemDetailsRouting: Routing {
    @ViewBuilder
    func view(for route: ItemDetailsRoute) -> some View {
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
                movieView: { ReviewsSectionContainer<AppState, ReviewsSectionRouting>(id: .movie($0.id)) },
                showView: { ReviewsSectionContainer<AppState, ReviewsSectionRouting>(id: .show($0.id)) }
            )

        case let .recommendations(item):
            buildView(
                item: item,
                movieView: { RecommendationsSectionContainer<AppState, RecommendationsSectionRouting>(id: .movie($0.id)) },
                showView: { RecommendationsSectionContainer<AppState, RecommendationsSectionRouting>(id: .show($0.id)) }
            )

        case let .whereToWatch(item):
            WhereToWatchContainer<AppState, WhereToWatchRouting>(item: item)
        }
    }
}
