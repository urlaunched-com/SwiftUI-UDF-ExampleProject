//
//  ReviewsRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 03.09.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import SwiftUI
import Reviews
import Image
import ReviewDetails

struct ReviewsRouting: Routing {
    @ViewBuilder func view(for route: ReviewsRoute) -> some View {
        switch route {
        case let .imageContainer(path: path, size: size, type: type):
            AppRouter.image(size: size, path: path, type: type)
        case let .reviewDetails(reviewID):
            AppRouter.reviewDetails(reviewID: reviewID)
        }
    }
}
