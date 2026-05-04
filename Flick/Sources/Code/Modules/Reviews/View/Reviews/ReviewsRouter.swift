//
//  ReviewsRouter.swift
//  Flick
//
//  Created by Alexander Sharko on 10.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

struct ReviewsRouting: Routing {
    enum Route: Hashable {
        case reviewDetails(Review.ID)
    }

    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case let .reviewDetails(id): ReviewDetailsContainer(reviewId: id)
        }
    }
}
