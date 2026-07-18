//
//  ItemDetailsReviewsRouter.swift
//  Flick
//
//  Created by Alexander Sharko on 08.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Models
import Common
import ItemDetailsReviewsComponent
import ReviewDetails

struct ItemDetailsReviewsRouting: Routing {
    @ViewBuilder func view(for route: ItemDetailsReviewsRoute) -> some View {
        switch route {
        case let .reviewDetails(id):
            ReviewDetailsContainer<AppState, ReviewDetailsRouting>(id: id)
        case let .reviews(item):
            if let movie = item as? Movie {
                MovieReviewsContainer(id: movie.id)
            } else if let show = item as? Show {
                ShowReviewsContainer(id: show.id)
            }
        }
    }
}
