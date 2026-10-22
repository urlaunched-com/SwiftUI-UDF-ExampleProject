//
//  ItemDetailsScreenRouting.swift
//  Flick
//
//  Created by Alexander Sharko on 20.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Models
import Common
import UDFMacros

@AutoHashable
enum ItemDetailsScreenRoute {
    case cast(any Item)
    case reviews(any Item)
    case recommendations(any Item)
    case whereToWatch(any Item)
    case imageContainer(path: String?, size: CGSize, type: ImageType = .poster)
}

struct ItemDetailsScreenRouting<AppState: ItemDetailsFeature>: Routing {
    @ViewBuilder func view(for route: ItemDetailsScreenRoute) -> some View {
        switch route {
        case let .cast(item):
            if let target = CastSectionTarget(item: item) {
                CastSectionContainer<AppState>(id: target)
            }
        case let .reviews(item):
            if let target = ReviewsTarget(item: item) {
                AppState.ItemDetailsRouting().view(for: .reviews(target))
            }
        case let .recommendations(item):
            if let target = RecomendationTarget(item: item) {
                RecommendationsSectionContainer<AppState>(id: target)
            }
        case let .whereToWatch(item):
            WhereToWatchContainer<AppState>(item: item)
        case let .imageContainer(path, size, type):
            AppState.ItemDetailsRouting().view(for: .imageContainer(path: path, size: size, type: type))
        }
    }
}
