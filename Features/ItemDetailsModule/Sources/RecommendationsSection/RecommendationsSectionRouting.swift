//
//  RecommendationsRoute.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Models
import Common
import UIKit
import SwiftUI
import UDF
import UDFMacros

@AutoHashable
enum RecommendationsSectionRoute {
    case itemDetails(any Item)
    case recommendations(any Item)
    case imageContainer(path: String?, size: CGSize)
}

struct RecommendationsSectionRouting<AppState: ItemDetailsFeature>: Routing {
    @ViewBuilder func view(for route: RecommendationsSectionRoute) -> some View {
        switch route {
        case let .itemDetails(item):
            if let target = ItemDetailsTarget(item: item) {
                ItemDetailsContainer<AppState>(id: target)
            }
        case let .recommendations(item):
            if let target = RecomendationTarget(item: item) {
                RecommendationsContainer<AppState>(id: target)
            }
        case let .imageContainer(path, size):
            AppState.ItemDetailsRouting().view(for: .imageContainer(path: path, size: size))
        }
    }
}
