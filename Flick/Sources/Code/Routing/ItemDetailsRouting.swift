//
//  ItemDetailsRouter.swift
//  Flick
//
//  Created by Alexander Sharko on 20.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import MediaModels
import ReviewModels
import Common
import WhereToWatch
import CastSection
import ItemDetails
import RecommendationsSection
import ReviewsSection
import Image

struct ItemDetailsRouting: Routing {
    @ViewBuilder
    func view(for route: ItemDetailsRoute) -> some View {
        switch route {
        case let .cast(item):
            buildView(
                item: item,
                movieView: {
                    AppRouter.castSection(id: .movie($0.id))
                },
                showView: {
                    AppRouter.castSection(id: .show($0.id))
                }
            )

        case let .reviews(item):
            AppRouter.reviewsSection(id: ReviewsTarget(mediaReference: item.mediaReference))

        case let .recommendations(item):
            AppRouter.recommendationsSection(id: item.mediaReference)

        case let .whereToWatch(item):
            AppRouter.whereToWatch(item: item)
        case let .imageContainer(path: path, size: size, type: type):
            AppRouter.image(size: size, path: path, type: type)
        }
    }
}
