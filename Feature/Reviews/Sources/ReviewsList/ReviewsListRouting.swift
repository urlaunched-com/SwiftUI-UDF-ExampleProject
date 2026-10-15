//
//  ReviewsListRouting.swift
//  Flick
//
//  Created by Alexander Sharko on 10.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Models
import Common
import UIKit

enum ReviewsListRoute: Hashable {
    case imageContainer(path: String?, size: CGSize, type: ImageType = .poster)
    case reviewDetails(Review.ID)
}

struct ReviewsListRouting<AppState: ReviewsFeature>: Routing {
    @ViewBuilder func view(for route: ReviewsListRoute) -> some View {
        switch route {
        case let .imageContainer(path, size, type):
            AppState.ReviewsRouting().view(for: .imageContainer(path: path, size: size, type: type))
        case let .reviewDetails(reviewID):
            ReviewDetailsContainer<AppState>(id: reviewID)
        }
    }
}
