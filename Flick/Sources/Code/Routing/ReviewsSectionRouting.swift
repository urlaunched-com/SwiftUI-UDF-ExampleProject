//
//  ReviewsSectionRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUI
import UDF
import Models
import ReviewsSection
import ReviewDetails
import Reviews
import Image

struct ReviewsSectionRouting: Routing {
    @ViewBuilder func view(for route: ReviewsSectionRoute) -> some View {
        switch route {
        case let .imageContainer(path: path, size: size, type: type):
            ImageEntryPoint<AppState>.make(with: .init(size: size, path: path, type: type))
        case let .reviewDetails(reviewID):
            AppRouter.reviewDetails(reviewID: reviewID)
        case let .reviews(id):
            AppRouter.reviews(id: id)
        }
    }
}
