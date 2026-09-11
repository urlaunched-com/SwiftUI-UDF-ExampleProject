//
//  ItemDetailsRecommendationsRouting.swift
//  Flick
//
//  Created by Alexander Sharko on 05.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Models
import Common
import Recommendations
import RecommendationsSection
import ItemDetails

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
            if let movie = item as? Movie {
                RecommendationsFeatureState<AppState, RecommendationsRouting>.entryPoint(input: .movie(movie.id))
            } else if let show = item as? Show {
                RecommendationsFeatureState<AppState, RecommendationsRouting>.entryPoint(input: .show(show.id))
            }
        case .imageContainer(path: let path, size: let size):
            AppRouter.image(size: size, path: path)
        }
    }
}
