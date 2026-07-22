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
import Image
import ItemDetails

struct RecommendationsSectionRouting: Routing {
    @ViewBuilder func view(for route: RecommendationsSectionRoute) -> some View {
        switch route {
        case let .itemDetails(item):
            if let movie = item as? Movie {
                ItemDetailsContainer<AppState, ItemDetailsRouting>(id: .movie(movie.id))
            } else if let show = item as? Show {
                ItemDetailsContainer<AppState, ItemDetailsRouting>(id: .show(show.id))
            }
        case let .recommendations(item):
            if let movie = item as? Movie {
                RecommendationsContainer<AppState, RecommendationsRouting>(id: .movie(movie.id))
            } else if let show = item as? Show {
                RecommendationsContainer<AppState, RecommendationsRouting>(id: .show(show.id))
            }
        case .imageContainer(path: let path, size: let size):
            ImageContainer<AppState>(size: size, path: path, type: .poster)
        }
    }
}
