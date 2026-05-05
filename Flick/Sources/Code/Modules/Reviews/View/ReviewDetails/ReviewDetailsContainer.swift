//
//  ReviewDetailsContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 10.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF
import Models

struct ReviewDetailsContainer: Container {
    typealias ContainerComponent = ReviewDetailsComponent

    let reviewId: Review.ID

    func scope(for state: AppState) -> Scope {
        state.allReviews
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            review: store.state.allReviews.byId[reviewId]!
        )
    }
}
