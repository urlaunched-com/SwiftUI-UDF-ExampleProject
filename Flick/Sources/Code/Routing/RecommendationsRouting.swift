//
//  RecommendationsRouting.swift
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
import Image

struct RecommendationsRouting: Routing {
    @ViewBuilder func view(for route: RecommendationsRoute) -> some View {
        switch route {
        case let .itemDetails(item):
            if let movie = item as? Movie {
                MovieDetailsContainer(id: movie.id)
            } else if let show = item as? Show {
                ShowDetailsContainer(id: show.id)
            }
        case .imageContainer(path: let path, size: let size):
            ImageContainer<AppState>(size: size, path: path)
        }
    }
}
