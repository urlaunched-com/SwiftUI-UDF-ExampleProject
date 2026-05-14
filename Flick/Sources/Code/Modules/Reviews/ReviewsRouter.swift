//
//  ReviewsRouter.swift
//  Flick
//
//  Created by Alexander Sharko on 10.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Models
import ReviewsComponent

struct ReviewsRouting: Routing {
    
    @ViewBuilder func view(for route: ReviewsRoute) -> some View {
        switch route {
        case let .reviewDetails(id): ReviewDetailsContainer(reviewId: id)
        }
    }
}
