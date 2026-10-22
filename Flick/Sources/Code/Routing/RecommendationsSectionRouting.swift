//
//  ItemDetailsRecommendationsRouting.swift
//  Flick
//
//  Created by Alexander Sharko on 05.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Common
import Recommendations
import RecommendationsSection
import ItemDetails
import MediaModels

struct RecommendationsSectionRouting: Routing {
    @ViewBuilder func view(for route: RecommendationsSectionRoute) -> some View {
        switch route {
        case let .itemDetails(item):
            if let movie = item as? Movie {
                ItemDetailsFeatureState<AppState, ItemDetailsRouting>.entryPoint(input: .movie(movie.id))
            } else if let show = item as? Show {
                ItemDetailsFeatureState<AppState, ItemDetailsRouting>.entryPoint(input: .show(show.id))
            }
        case let .recommendations(item):
            RecommendationsFeatureState<AppState, RecommendationsRouting>.entryPoint(input: item.mediaReference)
        case .imageContainer(path: let path, size: let size):
            AppRouter.image(size: size, path: path)
        }
    }
}
